###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

DiscoverSearchListHeaderDirective = () ->
    link = (scope, el, attrs) ->

    return {
        controller: "DiscoverSearchListHeader",
        controllerAs: "vm",
        bindToController: true,
        templateUrl: "discover/components/discover-search-list-header/discover-search-list-header.html",
        scope: {
            onChange: "&",
            orderBy: "="
        },
        link: link
    }

DiscoverSearchListHeaderDirective.$inject = []

angular.module("taigaDiscover").directive("tgDiscoverSearchListHeader", DiscoverSearchListHeaderDirective)
