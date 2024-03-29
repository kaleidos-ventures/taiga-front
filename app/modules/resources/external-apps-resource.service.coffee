###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

Resource = (urlsService, http) ->
    service = {}

    service.getApplicationToken = (applicationId, state) ->
        url = urlsService.resolve("applications")
        url = "#{url}/#{applicationId}/token?state=#{state}"
        return http.get(url).then (result) ->
            Immutable.fromJS(result.data)

    service.authorizeApplicationToken = (applicationId, state) ->
        url = urlsService.resolve("application-tokens")
        url = "#{url}/authorize"
        data = {
            "state": state
            "application": applicationId
        }

        return http.post(url, data).then (result) ->
            Immutable.fromJS(result.data)

    return () ->
        return {"externalapps": service}

Resource.$inject = ["$tgUrls", "$tgHttp"]

module = angular.module("taigaResources2")
module.factory("tgExternalAppsResource", Resource)
