/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Copyright (c) 2021-present Kaleidos INC
 */

var utils = require('../../utils');
var issuesHelper = require('../../helpers').issues;
var commonHelper = require('../../helpers').common;
var sharedFilters = require('../../shared/filters');

var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');

chai.use(chaiAsPromised);
var expect = chai.expect;

describe('issues list', function() {
    before(async function() {
        browser.get(browser.params.glob.host + 'project/project-3/issues');

        await browser.waitForAngular();

        utils.common.takeScreenshot('issues', 'issues');
    });

    describe('create Issue', function() {
        let createIssueLightbox = null;

        before(async function() {
            createIssueLightbox = issuesHelper.getCreateIssueLightbox();

            issuesHelper.openNewIssueLb();

            await createIssueLightbox.waitOpen();
        });

        it('capture screen', function() {
            utils.common.takeScreenshot('issues', 'create-issue');
        });

        it('fill form', async function() {
            // subject
            createIssueLightbox.subject().sendKeys('subject');

            // tags
            commonHelper.tags();
        });

        it('upload attachments', commonHelper.lightboxAttachment);

        it('screenshots', function() {
            utils.common.takeScreenshot('issues', 'create-issue-filled');
        });

        it('send form', async function() {
            createIssueLightbox.submit();

            let openNotification = await utils.notifications.success.open();

            expect(openNotification).to.be.true;

            await utils.notifications.success.close();
        });
    });

    describe('bulk create Issue', function() {
        let createIssueLightbox = null;

        before(async function() {
            issuesHelper.openBulk();

            createIssueLightbox = issuesHelper.getBulkCreateLightbox();

            createIssueLightbox.waitOpen();
        });

        it('fill form', function() {
            createIssueLightbox.textarea().sendKeys('aaa');
            browser.actions().sendKeys(protractor.Key.ENTER).perform();

            createIssueLightbox.textarea().sendKeys('bbb');
            browser.actions().sendKeys(protractor.Key.ENTER).perform();
        });

        it('send form', async function() {
            createIssueLightbox.submit();

            await createIssueLightbox.waitClose();

            let notificationSuccess = await utils.notifications.success.open();

            expect(notificationSuccess).to.be.be.true;

            await utils.notifications.success.close();
        });
    });

    it('change order', async function() {
        let table = issuesHelper.getTable();

        // test every column order
        for(let i = 0; i < 7; i++) {
            issuesHelper.clickColumn(i);
            await browser.waitForAngular();
            issuesHelper.clickColumn(i);
            await browser.waitForAngular();
        }
    });

    it('assignto to', async function() {
        let assignToLightbox = commonHelper.assignToLightbox();

        issuesHelper.openAssignTo(0);

        await assignToLightbox.waitOpen();

        let newUserName = await assignToLightbox.getName(2);

        assignToLightbox.select(2);

        await assignToLightbox.waitClose();

        let issueUserName = await issuesHelper.getAssignTo(0);

        expect(issueUserName).to.be.equal(newUserName);
    });

    it('change status', async function() {
        await issuesHelper.changeStatus(0, 1);

        let oldStatus = issuesHelper.getStatus(0);

        await issuesHelper.changeStatus(1, 1);

        let newStatus = issuesHelper.getStatus(0);

        expect(oldStatus).not.to.be.equal(newStatus);
    });

    describe('issues filters', sharedFilters.bind(this, 'issues', () => {
        return issuesHelper.getIssues().count();
    }));
});
