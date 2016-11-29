# coding=utf-8
"""
This file demonstrates writing tests using the unittest module. These will pass
when you run "manage.py test".

Replace this with more appropriate tests for your application.
"""
import datetime

from django.test import TestCase
from django.contrib.auth.models import User

from student.tests.factories import UserFactory

from lek_api.serializers import UserSerializer


API_PROFILE_FIELDS = (
    'name',
    'nickname',
    'first_name',
    'last_name',
    'birthdate',
    'city',
    'gender',
)


class UserSerializerTest(TestCase):
    profile_fields = API_PROFILE_FIELDS

    def setUp(self):
        self.user = UserFactory.create(username='test', email='test@example.com')

    def test_serialization(self):
        serializer = UserSerializer(instance=self.user)
        data = serializer.data

        self.assertIn('uid', data)
        self.assertEquals(self.user.username, data['uid'])

        self.assertIn('email', data)
        self.assertEquals(self.user.email, data['email'])

        for field_name in self.profile_fields:
            self.assertIn(field_name, data)
            self.assertEquals(getattr(self.user.profile, field_name), data[field_name])

    def test_repetitive_user_not_valid(self):
        serializer = UserSerializer(data={'uid': self.user.username})
        self.assertFalse(serializer.is_valid(), 'Validation unexpectedly succeded')

    def test_create(self):
        data = {
            'uid': 'test1',
            'email': 'test1@example.com',
            'name': 'Test',
            'nickname': 'Nick',
            'first_name': 'FirstTest',
            'last_name': 'LastTest',
            'birthdate': datetime.date.today(),
            'city': 'Test city',
            'gender': 'o'
        }
        serializer = UserSerializer(data=data)
        self.assertTrue(serializer.is_valid(), 'Validation on creaion failed: %s' % serializer.errors)

        new_user = serializer.save()
        self.assertEquals(new_user.username, serializer.data['uid'])
        self.assertEquals(new_user.email, serializer.data['email'])
        for field_name in self.profile_fields:
            self.assertEquals(getattr(new_user.profile, field_name), data[field_name])

    def test_update(self):
        data = {
            'uid': self.user.username,
            'email': 'new_test@example.com',
            'name': 'New Test',
            'nickname': 'New Test',
            'first_name': 'Test name',
            'last_name': 'Test surname',
        }
        serializer = UserSerializer(self.user, data=data)
        self.assertTrue(serializer.is_valid(), 'Validation on update failed: %s' % serializer.errors)

        serializer.save()
        updated_user = User.objects.get(id=self.user.id)
        self.assertEquals(updated_user.username, data['uid'])
        self.assertEquals(updated_user.email, data['email'])
        self.assertEquals(updated_user.profile.name, data['name'])
        self.assertEquals(updated_user.profile.nickname, data['nickname'])
        self.assertEquals(updated_user.profile.first_name, data['first_name'])
        self.assertEquals(updated_user.profile.last_name, data['last_name'])

    def test_optional_fields(self):
        data = {'uid': 'test2', 'email': 'test2@example.com'}
        serializer = UserSerializer(data=data)
        self.assertTrue(serializer.is_valid(), 'Validation on update failed: %s' % serializer.errors)

    def test_required_fields(self):
        data = {}
        serializer = UserSerializer(data=data)
        self.assertFalse(serializer.is_valid(), 'Validation unexpectedly succeded')
        self.assertIn('uid', serializer.errors)

    def test_email_required_on_creation(self):
        data = {'uid': 'testx'}
        serializer = UserSerializer(data=data)
        self.assertFalse(serializer.is_valid(), 'Validation unexpectedly succeded')
        self.assertIn('email', serializer.errors)

    def test_partial_update(self):
        """
        Test that not required fields with defaults are not changed during partial update
        """
        data = {
            'uid': self.user.username,
            'nickname': 'New Test'
        }
        profile = self.user.profile
        profile.name = 'not-to-be-changed'
        profile.save()

        serializer = UserSerializer(self.user, data=data, partial=True)
        self.assertTrue(serializer.is_valid(), 'Validation on update failed: %s' % serializer.errors)
        updated_user = serializer.save()
        self.assertEqual(updated_user.profile.nickname, data['nickname'])
        self.assertEqual(updated_user.profile.name, 'not-to-be-changed')

    def test_defaults_on_update(self):
        data = {
            'uid': self.user.username,
            'nickname': 'New Test'
        }
        profile = self.user.profile
        profile.name = 'to-be-removed'
        profile.save()

        serializer = UserSerializer(self.user, data=data)
        self.assertTrue(serializer.is_valid(), 'Validation on update failed: %s' % serializer.errors)
        updated_user = serializer.save()
        self.assertEqual(updated_user.profile.name, '')

    def test_invalid_on_duplicate_email(self):
        data = {
            'uid': self.user.username + '-new',
            'email': self.user.email,
        }
        serializer = UserSerializer(data=data)
        self.assertFalse(serializer.is_valid(), 'Validation unexpectedly succeded')

    def test_invalid_uid(self):
        data = {
            'uid': 'restricted+symbols in uid',
            'email': 'test@example.com',
        }
        serializer = UserSerializer(data=data)
        self.assertFalse(serializer.is_valid(), 'Validation unexpectedly succeded')
        self.assertIn('uid', serializer.errors)

