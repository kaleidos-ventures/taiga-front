###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

BoardZoomDirective = () ->
    return {
        scope: {
            levels: "=",
            value: "="
        },
        templateUrl: 'components/board-zoom/board-zoom.html'
    }

angular.module('taigaComponents').directive("tgBoardZoom", [BoardZoomDirective])
