###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

class ConfigurationService
    constructor: () ->
        @.config = window.taigaConfig

    get: (key, defaultValue=null) ->
        if _.has(@.config, key)
            return @.config[key]
        return defaultValue


module = angular.module("taigaBase")
module.service("$tgConfig", ConfigurationService)
