###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

module = angular.module("taigaProject")

createProjectMembersRestrictionsDirective = () ->
    return {
        scope: {
            isPrivate: '=',
            limitMembersPrivateProject: '=',
            limitMembersPublicProject: '='
        },
        templateUrl: "projects/create/create-project-members-restrictions/create-project-members-restrictions.html"
    }

module.directive('tgCreateProjectMembersRestrictions', [createProjectMembersRestrictionsDirective])
