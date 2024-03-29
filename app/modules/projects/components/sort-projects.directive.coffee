###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

SortProjectsDirective = (currentUserService) ->
    link = (scope, el, attrs, ctrl) ->
        itemEl = null

        drake = dragula([el[0]], {
            copySortSource: false,
            copy: false,
            mirrorContainer: el[0],
            moves: (item) -> return $(item).hasClass('list-itemtype-project')
        })

        drake.on 'dragend', (item) ->
            itemEl = $(item)
            project = itemEl.scope().project
            index = itemEl.index()

            sorted_project_ids = _.map(scope.projects.toJS(), (p) -> p.id)
            sorted_project_ids = _.without(sorted_project_ids, project.get("id"))
            sorted_project_ids.splice(index, 0, project.get('id'))

            sortData = []

            for value, index in sorted_project_ids
                sortData.push({"project_id": value, "order":index})

            currentUserService.bulkUpdateProjectsOrder(sortData)

        scroll = autoScroll(window, {
            margin: 20,
            pixels: 30,
            scrollWhenOutside: true,
            autoScroll: () ->
                return this.down && drake.dragging
        })

        scope.$on "$destroy", ->
            el.off()
            drake.destroy()

    directive = {
        scope: {
            projects: "=tgSortProjects"
        },
        link: link
    }

    return directive

angular.module("taigaProjects").directive("tgSortProjects", ["tgCurrentUserService", SortProjectsDirective])
