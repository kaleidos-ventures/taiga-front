/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Copyright (c) 2021-present Kaleidos INC
 */

var utils = require('../../../utils');

var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');

chai.use(chaiAsPromised);
var expect = chai.expect;

describe('project default values', function() {
    before(async function(){
        browser.get(browser.params.glob.host + 'project/project-0/admin/project-profile/default-values');

        await utils.common.waitLoader();

        utils.common.takeScreenshot('admin', 'project-default-values');
    });

    it('change serveral default values and save it', async function() {
        let fieldsets = $$('.default-values fieldset');

        fieldsets.get(0).$(`select option:nth-child(2)`).click();
        fieldsets.get(1).$(`select option:nth-child(2)`).click();

        $('button[type="submit"]').click();
        expect(utils.notifications.success.open()).to.be.eventually.equal(true);
    });
});
