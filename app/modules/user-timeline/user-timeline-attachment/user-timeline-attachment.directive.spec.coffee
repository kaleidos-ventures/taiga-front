###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

describe "userTimelineAttachmentDirective", () ->
    element = scope = compile = provide = null
    mockTgTemplate = null
    template = "<div tg-user-timeline-attachment='attachment'></div>"

    _mockTgTemplate= () ->
        mockTgTemplate = {
            get: sinon.stub()
        }

        provide.value "$tgTemplate", mockTgTemplate

    _mocks = () ->
        module ($provide) ->
            provide = $provide
            _mockTgTemplate()

            return null

    createDirective = () ->
        elm = compile(template)(scope)

        return elm

    beforeEach ->
        module "taigaUserTimeline"

        _mocks()

        inject ($rootScope, $compile) ->
            scope = $rootScope.$new()
            compile = $compile

    it "attachment image template", () ->
        scope.attachment =  Immutable.fromJS({
            url: "path/path/file.jpg"
        })

        mockTgTemplate.get
            .withArgs("user-timeline/user-timeline-attachment/user-timeline-attachment-image.html")
            .returns("<div id='image'></div>")

        elm = createDirective()

        expect(elm.find('#image')).to.have.length(1)

    it "attachment file template", () ->
        scope.attachment =  Immutable.fromJS({
            url: "path/path/file.pdf"
        })

        mockTgTemplate.get
            .withArgs("user-timeline/user-timeline-attachment/user-timeline-attachment.html")
            .returns("<div id='file'></div>")

        elm = createDirective()

        expect(elm.find('#file')).to.have.length(1)
