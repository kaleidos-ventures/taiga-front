###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

ProfileBarDirective = () ->
    return {
        templateUrl: "profile/profile-bar/profile-bar.html",
        controller: "ProfileBar",
        controllerAs: "vm",
        scope: {
            user: "=user",
            isCurrentUser: "=iscurrentuser"
        },
        bindToController: true
    }


angular.module("taigaProfile").directive("tgProfileBar", ProfileBarDirective)
