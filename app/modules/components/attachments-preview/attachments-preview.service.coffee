###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

class AttachmentsPreviewService extends taiga.Service
    @.$inject = []

    constructor: () ->

angular.module("taigaComponents").service("tgAttachmentsPreviewService", AttachmentsPreviewService)
