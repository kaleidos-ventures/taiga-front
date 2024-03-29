###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

IsolateClickDirective = () ->
    link = (scope, el, attrs) ->
        el.on 'click', (e) =>
            e.stopPropagation()

    return {link: link}

angular.module("taigaUtils").directive("tgIsolateClick", IsolateClickDirective)
