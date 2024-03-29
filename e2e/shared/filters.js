/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Copyright (c) 2021-present Kaleidos INC
 */

var filterHelper = require('../helpers/filters-helper');
var utils = require('../utils');

var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');

chai.use(chaiAsPromised);
var expect = chai.expect;

module.exports = function(name, counter) {
    before(async () => {
        await filterHelper.open();
        await browser.sleep(4000);

        utils.common.takeScreenshot(name, 'filters');
    });

    it('filter by ref', async () => {
        await filterHelper.byText('xxxxyy123123123');

        let len = await counter();
        len = await counter();

        await filterHelper.clearFilters();

        expect(len).to.be.equal(0);
    });

    it('filter by category', async () => {
        let len = await counter();

        await filterHelper.firterByCategoryWithContent();

        let newLength = await counter();

        expect(len).to.be.above(newLength);

        await filterHelper.clearFilters();

        newLength = await counter();

        expect(len).to.be.equal(newLength);
    });

    it('save custom filters', async () => {
        let customFiltersSize = await filterHelper.getCustomFilters().count();

        await filterHelper.firterByCategoryWithContent();
        await filterHelper.saveFilter("custom-filter");
        await filterHelper.clearFilters();

        let newCustomFiltersSize = await filterHelper.getCustomFilters().count();

        expect(newCustomFiltersSize).to.be.equal(customFiltersSize + 1);

    });

    it('remove custom filters', async () => {
        filterHelper.openCustomFiltersCategory();

        let customFiltersSize = await filterHelper.getCustomFilters().count();

        filterHelper.removeLastCustomFilter();

        let newCustomFiltersSize = await filterHelper.getCustomFilters().count();

        expect(newCustomFiltersSize).to.be.equal(customFiltersSize - 1);
    });

    after(async function() {
        await filterHelper.clearFilters();
    });
};
