// Jasmine Test Suite: Certifiate Editor View

define([ // jshint ignore:line
    'underscore',
    'js/models/course',
    'js/certificates/models/certificate',
    'js/certificates/models/signatory',
    'js/certificates/models/organization',
    'js/certificates/collections/certificates',
    'js/certificates/views/certificate_editor',
    'common/js/components/views/feedback_notification',
    'common/js/spec_helpers/ajax_helpers',
    'common/js/spec_helpers/template_helpers',
    'common/js/spec_helpers/view_helpers',
    'js/spec_helpers/validation_helpers',
    'js/certificates/spec/custom_matchers',
    'jquery.simulate'
],
function(_, Course, CertificateModel, SignatoryModel, OrganizationModel, CertificatesCollection, CertificateEditorView,
         Notification, AjaxHelpers, TemplateHelpers, ViewHelpers, ValidationHelpers, CustomMatchers) {
    'use strict';

    var MAX_SIGNATORIES = 100;
    var SELECTORS = {
        detailsView: '.certificate-details',
        editView: '.certificate-edit',
        itemView: '.certificates-list-item',
        name: '.certificate-name',
        description: '.certificate-description',
        errorMessage: '.certificate-edit-error',
        inputCertificateName: '.collection-name-input',
        inputCertificateDescription: '.certificate-description-input',
        inputCourseDescription: '.certificate-course-description-input',
        inputShowGrade: '.certificate-show-grade-input',
        inputHonorCodeDisclaimer: '.certificate-honor-code-disclaimer-input',
        inputSignatoryName: '.signatory-name-input',
        inputSignatoryTitle: '.signatory-title-input',
        inputSignatoryOrganization: '.signatory-organization-input',
        inputSignatorySignature: '.signatory-signature-input',
        inputOrganizationShortName: '.organization-short_name-input',
        addOrganizationButton: '.action-add-organization',
        organization_name: '.organization-name',
        organization_logo_image: '.organization-logo-image',
        organizationDeleteButton: '.action-delete-organization',
        warningMessage: '.certificate-validation-text',
        warningIcon: '.wrapper-certificate-validation > i',
        note: '.wrapper-delete-button',
        addSignatoryButton: '.action-add-signatory',
        signatoryDeleteButton: '.signatory-panel-delete',
        uploadSignatureButton:'.action-upload-signature',
        uploadDialog: 'form.upload-dialog',
        uploadDialogButton: '.action-upload',
        uploadDialogFileInput: 'form.upload-dialog input[type=file]',
        saveCertificateButton: 'button.action-primary'
    };

    var clickDeleteItem = function (that, promptText, element, url) {
        var requests = AjaxHelpers.requests(that),
            promptSpy = ViewHelpers.createPromptSpy(),
            notificationSpy = ViewHelpers.createNotificationSpy();
        that.view.$(element).click();

        ViewHelpers.verifyPromptShowing(promptSpy, promptText);
        ViewHelpers.confirmPrompt(promptSpy);
        ViewHelpers.verifyPromptHidden(promptSpy);
        if (!_.isUndefined(url)  && !_.isEmpty(url)){
            AjaxHelpers.expectJsonRequest(requests, 'POST', url);
            expect(_.last(requests).requestHeaders['X-HTTP-Method-Override']).toBe('DELETE');
            ViewHelpers.verifyNotificationShowing(notificationSpy, /Deleting/);
            AjaxHelpers.respondWithNoContent(requests);
            ViewHelpers.verifyNotificationHidden(notificationSpy);
        }
    };

    var showConfirmPromptAndClickCancel = function (view, element, promptText) {
        var promptSpy = ViewHelpers.createPromptSpy();
        view.$(element).click();
        ViewHelpers.verifyPromptShowing(promptSpy, promptText);
        ViewHelpers.confirmPrompt(promptSpy, true);
        ViewHelpers.verifyPromptHidden(promptSpy);
    };

    var uploadFile = function (file_path, requests){
        $(SELECTORS.uploadDialogFileInput).change();
        $(SELECTORS.uploadDialogButton).click();
        AjaxHelpers.respondWithJson(requests, {asset: {url: file_path}});
    };

    beforeEach(function() {
        window.course = new Course({
            id: '5',
            name: 'Course Name',
            url_name: 'course_name',
            org: 'course_org',
            num: 'course_num',
            revision: 'course_rev'
        });
        window.CMS.User = {isGlobalStaff: true};
    });

    afterEach(function() {
        delete window.course;
        delete window.CMS.User;
    });

    describe('Certificate editor view', function() {
        var setValuesToInputs = function (view, values) {
            _.each(values, function (value, selector) {
                if (SELECTORS[selector]) {
                    view.$(SELECTORS[selector]).val(value);
                    view.$(SELECTORS[selector]).trigger('change');
                }
            });
        };
        var basicModalTpl = readFixtures('basic-modal.underscore'),
        modalButtonTpl = readFixtures('modal-button.underscore'),
        uploadDialogTpl = readFixtures('upload-dialog.underscore');

        beforeEach(function() {
            TemplateHelpers.installTemplates(['certificate-editor', 'signatory-editor', 'organization-details', 'organizations-editor'], true);

            window.organizationsList = [
                {
                    short_name: 'TEST',
                    long_name: 'Test Organization',
                    logo: '//logo'
                }
            ]
            this.newModelOptions = {add: true};
            this.model = new CertificateModel({
                name: 'Test Name',
                description: 'Test Description',
                is_active: true,
                show_grade: false,
                organizations: []
            }, this.newModelOptions);

            this.collection = new CertificatesCollection([ this.model ], {
                certificateUrl: '/certificates/'+ window.course.id
            });
            this.model.set('id', 0);
            this.view = new CertificateEditorView({
                model: this.model
            });
            appendSetFixtures(this.view.render().el);
            CustomMatchers(this); // jshint ignore:line
        });

        describe('Basic', function () {
            beforeEach(function(){
                appendSetFixtures(
                    $("<script>", { id: "basic-modal-tpl", type: "text/template" }).text(basicModalTpl)
                );
                appendSetFixtures(
                    $("<script>", { id: "modal-button-tpl", type: "text/template" }).text(modalButtonTpl)
                );
                appendSetFixtures(
                    $("<script>", { id: "upload-dialog-tpl", type: "text/template" }).text(uploadDialogTpl)
                );
            });

            afterEach(function(){
                $('.wrapper-modal-window-assetupload').remove();
            });

            it('can render properly', function() {
                expect(this.view.$("[name='certificate-name']").val()).toBe('Test Name');
                expect(this.view.$("[name='certificate-description']").val()).toBe('Test Description');
                expect(this.view.$('.action-delete')).toExist();
            });

            it('should not have delete button if user is not global staff and certificate is active', function() {
                window.CMS.User = {isGlobalStaff: false};
                appendSetFixtures(this.view.render().el);
                expect(this.view.$('.action-delete')).not.toExist();
            });

            it('should save properly', function() {
                var requests = AjaxHelpers.requests(this),
                    notificationSpy = ViewHelpers.createNotificationSpy();
                this.view.$('.action-add').click();

                setValuesToInputs(this.view, {
                    inputCertificateName: 'New Test Name',
                    inputCertificateDescription: 'New Test Description'
                });

                ViewHelpers.submitAndVerifyFormSuccess(this.view, requests, notificationSpy);
                expect(this.model).toBeCorrectValuesInModel({
                    name: 'New Test Name',
                    description: 'New Test Description'
                });
            });

            it('should save additional information', function() {
                var requests = AjaxHelpers.requests(this),
                    notificationSpy = ViewHelpers.createNotificationSpy();
                this.view.$('.action-add').click();

                setValuesToInputs(this.view, {
                    inputCourseDescription: 'New Test Course Description',
                    inputHonorCodeDisclaimer: 'New Test Honor Code Disclaimer'
                });
                this.view.$(SELECTORS['inputShowGrade']).prop('checked', true).trigger('change');

                ViewHelpers.submitAndVerifyFormSuccess(this.view, requests, notificationSpy);
                expect(this.model).toBeCorrectValuesInModel({
                    course_description: 'New Test Course Description',
                    show_grade: true,
                    honor_code_disclaimer: 'New Test Honor Code Disclaimer'
                });
            });

            it('does not hide saving message if failure', function() {
                var requests = AjaxHelpers.requests(this),
                    notificationSpy = ViewHelpers.createNotificationSpy();
                this.view.$(SELECTORS.inputCertificateName).val('New Test Name');
                this.view.$(SELECTORS.inputCertificateDescription).val('New Test Description');
                ViewHelpers.submitAndVerifyFormError(this.view, requests, notificationSpy);
            });

            it('does not save on cancel', function() {
                // When we cancel the action, the model values should be reverted to original state
                // And the model should still be present in the collection
                expect(this.view.$('.action-add'));
                this.view.$('.action-add').click();
                this.view.$(SELECTORS.inputCertificateName).val('New Certificate');
                this.view.$(SELECTORS.inputCertificateDescription).val('New Certificate Description');

                this.view.$('.action-cancel').click();
                expect(this.model).toBeCorrectValuesInModel({
                    name: 'Test Name',
                    description: 'Test Description'
                });
                expect(this.collection.length).toBe(1);
            });

            it('user can only add signatories up to max 100', function() {
                for(var i = 1; i < MAX_SIGNATORIES ; i++) {
                    this.view.$(SELECTORS.addSignatoryButton).click();
                }
                expect(this.view.$(SELECTORS.addSignatoryButton)).toHaveClass('disableClick');

            });

            it('user can add signatories if not reached the upper limit', function() {
                spyOnEvent(SELECTORS.addSignatoryButton, 'click');
                this.view.$(SELECTORS.addSignatoryButton).click();
                expect('click').not.toHaveBeenPreventedOn(SELECTORS.addSignatoryButton);
                expect(this.view.$(SELECTORS.addSignatoryButton)).not.toHaveClass('disableClick');
            });

            it('user can add signatories when signatory reached the upper limit But after deleting a signatory',
                function() {
                    for(var i = 1; i < MAX_SIGNATORIES ; i++) {
                        this.view.$(SELECTORS.addSignatoryButton).click();
                    }
                    expect(this.view.$(SELECTORS.addSignatoryButton)).toHaveClass('disableClick');

                    // now delete anyone of the signatory, Add signatory should be enabled.
                    var signatory = this.model.get('signatories').at(0);
                    var text = 'Delete "'+ signatory.get('name') +'" from the list of signatories?';
                    clickDeleteItem(this, text, SELECTORS.signatoryDeleteButton + ':first');
                    expect(this.view.$(SELECTORS.addSignatoryButton)).not.toHaveClass('disableClick');
                }
            );

            it('signatories should save when fields have too many characters per line', function() {
                this.view.$(SELECTORS.addSignatoryButton).click();
                setValuesToInputs(this.view, {
                    inputCertificateName: 'New Certificate Name that has too many characters without any limit'
                });

                setValuesToInputs(this.view, {
                    inputSignatoryName: 'New Signatory Name'
                });

                setValuesToInputs(this.view, {
                    inputSignatoryTitle: 'This is a certificate signatory title that has waaaaaaay more than 106 characters, in order to cause an exception.'
                });

                this.view.$(SELECTORS.saveCertificateButton).click();
                expect(this.view.$('.certificate-edit-error')).not.toHaveClass('is-shown');
            });

            it('signatories should save when title span on more than 2 lines', function() {
                this.view.$(SELECTORS.addSignatoryButton).click();
                setValuesToInputs(this.view, {
                    inputCertificateName: 'New Certificate Name'
                });

                setValuesToInputs(this.view, {
                    inputSignatoryName: 'New Signatory Name longer than 40 characters'
                });

                setValuesToInputs(this.view, {
                    inputSignatoryTitle: 'Signatory Title \non three \nlines'
                });

                setValuesToInputs(this.view, {
                    inputSignatorySignature: '/c4x/edX/DemoX/asset/Signature-450.png'
                });

                this.view.$(SELECTORS.saveCertificateButton).click();
                expect(this.view.$('.certificate-edit-error')).not.toHaveClass('is-shown');
            });

            it('user can delete those signatories already saved', function() {
                this.view.$(SELECTORS.addSignatoryButton).click();
                var total_signatories = this.model.get('signatories').length;
                var signatory = this.model.get('signatories').at(0);
                var signatory_url = '/certificates/signatory';
                signatory.url = signatory_url;
                spyOn(signatory, "isNew").andReturn(false);
                var text = 'Delete "'+ signatory.get('name') +'" from the list of signatories?';
                clickDeleteItem(this, text, SELECTORS.signatoryDeleteButton + ':first', signatory_url);
                expect(this.model.get('signatories').length).toEqual(total_signatories - 1);
            });

            it('can cancel deletion of signatories', function() {
                this.view.$(SELECTORS.addSignatoryButton).click();
                var signatory = this.model.get('signatories').at(0);
                spyOn(signatory, "isNew").andReturn(false);
                // add one more signatory
                this.view.$(SELECTORS.addSignatoryButton).click();
                var total_signatories = this.model.get('signatories').length;
                var signatory_url = '/certificates/signatory';
                signatory.url = signatory_url;
                var text = 'Delete "'+ signatory.get('name') +'" from the list of signatories?';
                showConfirmPromptAndClickCancel(this.view, SELECTORS.signatoryDeleteButton + ':first', text);
                expect(this.model.get('signatories').length).toEqual(total_signatories);
            });

            it('signatories should save properly', function() {
                var requests = AjaxHelpers.requests(this),
                    notificationSpy = ViewHelpers.createNotificationSpy();
                this.view.$('.action-add').click();

                setValuesToInputs(this.view, {
                    inputCertificateName: 'New Test Name'
                });

                setValuesToInputs(this.view, {
                    inputCertificateDescription: 'New Test Description'
                });

                setValuesToInputs(this.view, {
                    inputSignatoryName: 'New Signatory Name'
                });

                setValuesToInputs(this.view, {
                    inputSignatoryTitle: 'New Signatory Title'
                });

                setValuesToInputs(this.view, {
                    inputSignatoryOrganization: 'New Signatory Organization'
                });

                this.view.$(SELECTORS.uploadSignatureButton).click();
                var sinature_image_path = '/c4x/edX/DemoX/asset/Signature-450.png';
                uploadFile(sinature_image_path, requests);

                ViewHelpers.submitAndVerifyFormSuccess(this.view, requests, notificationSpy);
                expect(this.model).toBeCorrectValuesInModel({
                    name: 'New Test Name',
                    description: 'New Test Description'
                });

                // get the first signatory from the signatories collection.
                var signatory = this.model.get('signatories').at(0);
                expect(signatory).toBeInstanceOf(SignatoryModel);
                expect(signatory.get('name')).toEqual('New Signatory Name');
                expect(signatory.get('title')).toEqual('New Signatory Title');
                expect(signatory.get('organization')).toEqual('New Signatory Organization');
                expect(signatory.get('signature_image_path')).toEqual(sinature_image_path);
            });
        });

        describe('Organizations', function() {
            it('should add organization with valid short name and display its details', function() {
                setValuesToInputs(this.view, {inputOrganizationShortName: 'TEST'});

                // expect(this.view.$(SELECTORS.addOrganizationButton)).not.toHaveClass('disableClick');
                this.view.$(SELECTORS.addOrganizationButton).click();

                var organization = this.model.get('organizations').at(0);
                expect(organization.get('short_name')).toEqual('TEST');

                expect(this.view.$(SELECTORS.organization_name)).toContainText('Test Organization');
                expect(this.view.$(SELECTORS.organization_logo_image).attr('src')).toContain('//logo');
                expect(this.view.$(SELECTORS.organizationDeleteButton)).toExist();

            });

            it('should add organization on hitting return', function() {
                setValuesToInputs(this.view, {
                    inputOrganizationShortName: 'TEST'
                });
                this.view.$(SELECTORS.inputOrganizationShortName).simulate("keyup", {keyCode: $.simulate.keyCode.ENTER});

                var organization = this.model.get('organizations').at(0);
                expect(organization.get('short_name')).toEqual('TEST');
            });

            it('user can delete organizations', function() {
                var requests = AjaxHelpers.requests(this),
                    notificationSpy = ViewHelpers.createNotificationSpy();

                setValuesToInputs(this.view, {inputOrganizationShortName: 'TEST'});
                this.view.$(SELECTORS.addOrganizationButton).click();

                var total_organizations = this.model.get('organizations').length;
                var organization = this.model.get('organizations').at(0);
                // Simply delete organization without prompting: it's easily reverted
                this.view.$(SELECTORS.organizationDeleteButton).click();
                ViewHelpers.submitAndVerifyFormSuccess(this.view, requests, notificationSpy);

                expect(this.model.get('organizations').length).toEqual(total_organizations - 1);
            });

            it('can cancel deletion of organizations', function() {
                var requests = AjaxHelpers.requests(this),
                    notificationSpy = ViewHelpers.createNotificationSpy();
                var total_organizations = this.model.get('organizations').length;

                setValuesToInputs(this.view, {inputOrganizationShortName: 'TEST'});
                this.view.$(SELECTORS.addOrganizationButton).click();
                ViewHelpers.submitAndVerifyFormSuccess(this.view, requests, notificationSpy);
                expect(this.model.get('organizations').length, total_organizations + 1);

                this.view.render();
                this.view.$(SELECTORS.organizationDeleteButton).filter(':first').click();
                expect(this.model.get('organizations').length, total_organizations);

                this.view.$('.action-cancel').click();
                expect(this.model.get('organizations').length, total_organizations + 1);
            });

            it('organizations should save properly', function() {
                var requests = AjaxHelpers.requests(this),
                    notificationSpy = ViewHelpers.createNotificationSpy();

                setValuesToInputs(this.view, {inputOrganizationShortName: 'TEST'});
                this.view.$('.action-add-organization').click();
                ViewHelpers.submitAndVerifyFormSuccess(this.view, requests, notificationSpy);

                // get the first organization from the organizations collection.
                var organization = this.model.get('organizations').at(0);
                expect(organization).toBeInstanceOf(OrganizationModel);
                expect(organization.get('short_name')).toEqual('TEST');
            });

            it('should reject organization with invalid short name and display error message', function() {
                var total_organizations = this.model.get('organizations').length;

                // set value and check button click
                setValuesToInputs(this.view, {inputOrganizationShortName: 'INVALID'});
                this.view.$('.action-add-organization').click();
                expect(this.model.get('organizations').length).toEqual(total_organizations);

                // check keyboard events handling
                this.view.$(SELECTORS.inputOrganizationShortName).simulate("keyup", {keyCode: $.simulate.keyCode.ENTER});
                expect(this.model.get('organizations').length).toEqual(total_organizations);

                expect(this.view.$('.message-error:visible')).toContainText('No organization found');
            });

            it('should reject duplicate organization and display error message', function() {
                setValuesToInputs(this.view, {inputOrganizationShortName: 'TEST'});
                this.view.$(SELECTORS.addOrganizationButton).click();

                var organization = this.model.get('organizations').at(0);
                expect(organization.get('short_name')).toEqual('TEST');
                var total_organizations = this.model.get('organizations').length;

                // try to add organization with the same name
                setValuesToInputs(this.view, {inputOrganizationShortName: 'TEST'});
                this.view.$('.action-add-organization').click();
                expect(this.model.get('organizations').length).toEqual(total_organizations);

                this.view.$(SELECTORS.inputOrganizationShortName).simulate("keyup", {keyCode: $.simulate.keyCode.ENTER});
                expect(this.model.get('organizations').length).toEqual(total_organizations);
                expect(this.view.$('.message-error:visible')).toContainText('Organization already added');
            });
        });
    });
});
