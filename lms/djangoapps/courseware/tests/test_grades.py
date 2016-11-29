"""
Test grade calculation.
"""
from django.http import Http404
from django.test import TestCase
from django.test.client import RequestFactory

from nose.plugins.attrib import attr
from mock import patch, MagicMock, PropertyMock
from opaque_keys.edx.locations import SlashSeparatedCourseKey
from opaque_keys.edx.locator import CourseLocator, BlockUsageLocator

from courseware.grades import field_data_cache_for_grading, grade, iterate_grades_for, MaxScoresCache, ProgressSummary
from student.tests.factories import UserFactory, CourseEnrollmentFactory
from student.models import CourseEnrollment
from xmodule.modulestore.tests.factories import CourseFactory, ItemFactory
from xmodule.modulestore.tests.django_utils import ModuleStoreTestCase, SharedModuleStoreTestCase


def _grade_with_errors(student, request, course, keep_raw_scores=False):
    """This fake grade method will throw exceptions for student3 and
    student4, but allow any other students to go through normal grading.

    It's meant to simulate when something goes really wrong while trying to
    grade a particular student, so we can test that we won't kill the entire
    course grading run.
    """
    if student.username in ['student3', 'student4']:
        raise Exception("I don't like {}".format(student.username))

    return grade(student, request, course, keep_raw_scores=keep_raw_scores)


@attr('shard_1')
class TestGradeIteration(ModuleStoreTestCase):
    """
    Test iteration through student gradesets.
    """
    COURSE_NUM = "1000"
    COURSE_NAME = "grading_test_course"

    def setUp(self):
        """
        Create a course and a handful of users to assign grades
        """
        super(TestGradeIteration, self).setUp()

        self.course = CourseFactory.create(
            display_name=self.COURSE_NAME,
            number=self.COURSE_NUM
        )
        self.students = [
            UserFactory.create(username='student1'),
            UserFactory.create(username='student2'),
            UserFactory.create(username='student3'),
            UserFactory.create(username='student4'),
            UserFactory.create(username='student5'),
        ]

    def test_empty_student_list(self):
        """If we don't pass in any students, it should return a zero-length
        iterator, but it shouldn't error."""
        gradeset_results = list(iterate_grades_for(self.course.id, []))
        self.assertEqual(gradeset_results, [])

    def test_nonexistent_course(self):
        """If the course we want to get grades for does not exist, a `Http404`
        should be raised. This is a horrible crossing of abstraction boundaries
        and should be fixed, but for now we're just testing the behavior. :-("""
        with self.assertRaises(Http404):
            gradeset_results = iterate_grades_for(SlashSeparatedCourseKey("I", "dont", "exist"), [])
            gradeset_results.next()

    def test_all_empty_grades(self):
        """No students have grade entries"""
        all_gradesets, all_errors = self._gradesets_and_errors_for(self.course.id, self.students)
        self.assertEqual(len(all_errors), 0)
        for gradeset in all_gradesets.values():
            self.assertIsNone(gradeset['grade'])
            self.assertEqual(gradeset['percent'], 0.0)

    @patch('courseware.grades.grade', _grade_with_errors)
    def test_grading_exception(self):
        """Test that we correctly capture exception messages that bubble up from
        grading. Note that we only see errors at this level if the grading
        process for this student fails entirely due to an unexpected event --
        having errors in the problem sets will not trigger this.

        We patch the grade() method with our own, which will generate the errors
        for student3 and student4.
        """
        all_gradesets, all_errors = self._gradesets_and_errors_for(self.course.id, self.students)
        student1, student2, student3, student4, student5 = self.students
        self.assertEqual(
            all_errors,
            {
                student3: "I don't like student3",
                student4: "I don't like student4"
            }
        )

        # But we should still have five gradesets
        self.assertEqual(len(all_gradesets), 5)

        # Even though two will simply be empty
        self.assertFalse(all_gradesets[student3])
        self.assertFalse(all_gradesets[student4])

        # The rest will have grade information in them
        self.assertTrue(all_gradesets[student1])
        self.assertTrue(all_gradesets[student2])
        self.assertTrue(all_gradesets[student5])

    ################################# Helpers #################################
    def _gradesets_and_errors_for(self, course_id, students):
        """Simple helper method to iterate through student grades and give us
        two dictionaries -- one that has all students and their respective
        gradesets, and one that has only students that could not be graded and
        their respective error messages."""
        students_to_gradesets = {}
        students_to_errors = {}

        for student, gradeset, err_msg in iterate_grades_for(course_id, students):
            students_to_gradesets[student] = gradeset
            if err_msg:
                students_to_errors[student] = err_msg

        return students_to_gradesets, students_to_errors


class TestMaxScoresCache(ModuleStoreTestCase):
    """
    Tests for the MaxScoresCache
    """
    def setUp(self):
        super(TestMaxScoresCache, self).setUp()
        self.student = UserFactory.create()
        self.course = CourseFactory.create()
        self.problems = []
        for _ in xrange(3):
            self.problems.append(
                ItemFactory.create(category='problem', parent=self.course)
            )

        CourseEnrollment.enroll(self.student, self.course.id)
        self.request = RequestFactory().get('/')
        self.locations = [problem.location for problem in self.problems]

    def test_max_scores_cache(self):
        """
        Tests the behavior fo the MaxScoresCache
        """
        max_scores_cache = MaxScoresCache("test_max_scores_cache")
        self.assertEqual(max_scores_cache.num_cached_from_remote(), 0)
        self.assertEqual(max_scores_cache.num_cached_updates(), 0)

        # add score to cache
        max_scores_cache.set(self.locations[0], 1)
        self.assertEqual(max_scores_cache.num_cached_updates(), 1)

        # push to remote cache
        max_scores_cache.push_to_remote()

        # create a new cache with the same params, fetch from remote cache
        max_scores_cache = MaxScoresCache("test_max_scores_cache")
        max_scores_cache.fetch_from_remote(self.locations)

        # see cache is populated
        self.assertEqual(max_scores_cache.num_cached_from_remote(), 1)


class TestFieldDataCacheScorableLocations(ModuleStoreTestCase):
    """
    Make sure we can filter the locations we pull back student state for via
    the FieldDataCache.
    """
    def setUp(self):
        super(TestFieldDataCacheScorableLocations, self).setUp()
        self.student = UserFactory.create()
        self.course = CourseFactory.create()
        chapter = ItemFactory.create(category='chapter', parent=self.course)
        sequential = ItemFactory.create(category='sequential', parent=chapter)
        vertical = ItemFactory.create(category='vertical', parent=sequential)
        ItemFactory.create(category='video', parent=vertical)
        ItemFactory.create(category='html', parent=vertical)
        ItemFactory.create(category='discussion', parent=vertical)
        ItemFactory.create(category='problem', parent=vertical)

        CourseEnrollment.enroll(self.student, self.course.id)

    def test_field_data_cache_scorable_locations(self):
        """Only scorable locations should be in FieldDataCache.scorable_locations."""
        fd_cache = field_data_cache_for_grading(self.course, self.student)
        block_types = set(loc.block_type for loc in fd_cache.scorable_locations)
        self.assertNotIn('video', block_types)
        self.assertNotIn('html', block_types)
        self.assertNotIn('discussion', block_types)
        self.assertIn('problem', block_types)


class TestProgressSummary(TestCase):
    """
    Test the method that calculates the score for a given block based on the
    cumulative scores of its children. This test class uses a hard-coded block
    hierarchy with scores as follows:
                                                a
                                       +--------+--------+
                                       b                 c
                        +--------------+-----------+     |
                        d              e           f     g
                     +-----+     +-----+-----+     |     |
                     h     i     j     k     l     m     n
                   (2/5) (3/5) (0/1)   -   (1/3)   -   (3/10)

    """
    def setUp(self):
        super(TestProgressSummary, self).setUp()
        self.course_key = CourseLocator(
            org='some_org',
            course='some_course',
            run='some_run'
        )
        self.loc_a = self.create_location('chapter', 'a')
        self.loc_b = self.create_location('section', 'b')
        self.loc_c = self.create_location('section', 'c')
        self.loc_d = self.create_location('vertical', 'd')
        self.loc_e = self.create_location('vertical', 'e')
        self.loc_f = self.create_location('vertical', 'f')
        self.loc_g = self.create_location('vertical', 'g')
        self.loc_h = self.create_location('problem', 'h')
        self.loc_i = self.create_location('problem', 'i')
        self.loc_j = self.create_location('problem', 'j')
        self.loc_k = self.create_location('html', 'k')
        self.loc_l = self.create_location('problem', 'l')
        self.loc_m = self.create_location('html', 'm')
        self.loc_n = self.create_location('problem', 'n')

        weighted_scores = {
            self.loc_h: self.create_score(2, 5),
            self.loc_i: self.create_score(3, 5),
            self.loc_j: self.create_score(0, 1),
            self.loc_l: self.create_score(1, 3),
            self.loc_n: self.create_score(3, 10),
        }
        locations_to_scored_children = {
            self.loc_a: [self.loc_h, self.loc_i, self.loc_j, self.loc_l, self.loc_n],
            self.loc_b: [self.loc_h, self.loc_i, self.loc_j, self.loc_l],
            self.loc_c: [self.loc_n],
            self.loc_d: [self.loc_h, self.loc_i],
            self.loc_e: [self.loc_j, self.loc_l],
            self.loc_f: [],
            self.loc_g: [self.loc_n],
            self.loc_k: [],
            self.loc_m: [],
        }
        self.progress_summary = ProgressSummary(
            None, weighted_scores, locations_to_scored_children
        )

    def create_score(self, earned, possible):
        """
        Create a new mock Score object with specified earned and possible values
        """
        score = MagicMock()
        score.possible = possible
        score.earned = earned
        return score

    def create_location(self, block_type, block_id):
        """
        Create a new BlockUsageLocation with the given type and ID.
        """
        return BlockUsageLocator(
            course_key=self.course_key, block_type=block_type, block_id=block_id
        )

    def test_score_chapter(self):
        earned, possible = self.progress_summary.score_for_module(self.loc_a)
        self.assertEqual(earned, 9)
        self.assertEqual(possible, 24)

    def test_score_section_many_leaves(self):
        earned, possible = self.progress_summary.score_for_module(self.loc_b)
        self.assertEqual(earned, 6)
        self.assertEqual(possible, 14)

    def test_score_section_one_leaf(self):
        earned, possible = self.progress_summary.score_for_module(self.loc_c)
        self.assertEqual(earned, 3)
        self.assertEqual(possible, 10)

    def test_score_vertical_two_leaves(self):
        earned, possible = self.progress_summary.score_for_module(self.loc_d)
        self.assertEqual(earned, 5)
        self.assertEqual(possible, 10)

    def test_score_vertical_two_leaves_one_unscored(self):
        earned, possible = self.progress_summary.score_for_module(self.loc_e)
        self.assertEqual(earned, 1)
        self.assertEqual(possible, 4)

    def test_score_vertical_no_score(self):
        earned, possible = self.progress_summary.score_for_module(self.loc_f)
        self.assertEqual(earned, 0)
        self.assertEqual(possible, 0)

    def test_score_vertical_one_leaf(self):
        earned, possible = self.progress_summary.score_for_module(self.loc_g)
        self.assertEqual(earned, 3)
        self.assertEqual(possible, 10)

    def test_score_leaf(self):
        earned, possible = self.progress_summary.score_for_module(self.loc_h)
        self.assertEqual(earned, 2)
        self.assertEqual(possible, 5)

    def test_score_leaf_no_score(self):
        earned, possible = self.progress_summary.score_for_module(self.loc_m)
        self.assertEqual(earned, 0)
        self.assertEqual(possible, 0)


@attr('shard_1')
class FinalGradeTest(SharedModuleStoreTestCase):
    """
    Test computing of final course grade
    """
    GRADING_POLICY = {
        "GRADER": [{
            'type': 'Exam',
            'min_count': 1,
            'drop_count': 0,
            'short_label': 'Exam',
            'weight': 1
        }],
        "GRADE_CUTOFFS": {'A': 0.9, 'B': 0.6}
    }

    def setUp(self):
        """
        Create a course and a user to assign grades
        """
        super(FinalGradeTest, self).setUp()

        self.course = CourseFactory.create(
            grading_policy = self.GRADING_POLICY
        )
        self.student = UserFactory.create()
        CourseEnrollmentFactory.create(user=self.student, course_id=self.course.id)

    def test_grade_with_distinction(self):
        """
        Test the result of grading includes "distinction" item set to True
        if student gets grade over largest grade cutoff
        """
        with patch('xmodule.course_module.CourseDescriptor.grader', PropertyMock) as mock_grader:
            mock_grader.grade = MagicMock(return_value={'percent': 0.95})

            result = grade(self.student, RequestFactory(), self.course)
            self.assertIn('distinction', result)
            self.assertTrue(result['distinction'], 'The distinction is not calculated correctly')

    def test_grade_no_distinction(self):
        """
        Test the result of grading includes "distinction" item set to False
        if student gets grade under largest grade cutoff
        """
        with patch('xmodule.course_module.CourseDescriptor.grader', PropertyMock) as mock_grader:
            mock_grader.grade = MagicMock(return_value={'percent': 0.75})

            result = grade(self.student, RequestFactory(), self.course)
            self.assertIn('distinction', result)
            self.assertFalse(result['distinction'], 'The distinction is not calculated correctly')
