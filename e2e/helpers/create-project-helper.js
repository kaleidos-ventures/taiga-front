/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Copyright (c) 2021-present Kaleidos INC
 */

var utils = require('../utils');

var helper = module.exports;

helper.openCreateProjectPage = function() {
    $$('.create-project-btn').get(1).click();
};

helper.newProjectScreen = function() {
    let obj = {
        selectDuplicateOption: function() {
            return utils.common.link($('.e2e-duplicate-project'));
        },
        selectScrumOption: function() {
            return utils.common.link($('.e2e-create-project-scrum'));
        },
        selectKanbanOption: function() {
            return utils.common.link($('.e2e-create-project-kanban'));
        },
        selectProjectToDuplicate: function() {
            return $$('.e2e-duplicate-project-reference option').get(1).click();
        },
        fillNameAndDescription: async function(name, title){
          await $('.e2e-create-project-title').sendKeys(name);
          await $('.e2e-create-project-description').sendKeys(title);
        },
        createProject: function() {
            return $('.e2e-create-project-action-submit').click();
        }
    };

    return obj;
}

helper.delete = async function() {
    $('.delete-project').click();

    let lb = $('div[tg-lb-delete-project]');

    await utils.lightbox.open(lb);

    return lb.$('.button-green').click();
};
