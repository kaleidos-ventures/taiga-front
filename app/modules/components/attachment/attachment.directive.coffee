###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

AttachmentDirective = () ->
    link = (scope, el, attrs, ctrl) ->

    return {
        scope: {},
        bindToController: {
            attachment: "=",
            onDelete: "&",
            onUpdate: "&",
            type: "="
        },
        controller: "Attachment",
        controllerAs: "vm",
        templateUrl: "components/attachment/attachment.html",
        link: link
    }

AttachmentDirective.$inject = []

angular.module("taigaComponents").directive("tgAttachment", AttachmentDirective)
