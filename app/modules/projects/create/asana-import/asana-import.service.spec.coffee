###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC
###

describe "tgAsanaImportService", ->
    $provide = null
    $rootScope = null
    $q = null
    service = null
    mocks = {}

    _mockResources = ->
        mocks.resources = {
            asanaImporter: {
                listProjects: sinon.stub(),
                listUsers: sinon.stub(),
                importProject: sinon.stub(),
                getAuthUrl: sinon.stub(),
                authorize: sinon.stub()
            }
        }

        $provide.value("tgResources", mocks.resources)

    _mockLocation = ->
        mocks.location = {
            search: sinon.stub()
        }

        mocks.location.search.returns({
            from: 'asana'
            token: 123
        })

        $provide.value("$location", mocks.location)

    _mocks = ->
        module (_$provide_) ->
            $provide = _$provide_

            _mockResources()
            _mockLocation()

            return null

    _inject = ->
        inject (_tgAsanaImportService_, _$rootScope_, _$q_) ->
            service = _tgAsanaImportService_
            $rootScope = _$rootScope_
            $q = _$q_

    _setup = ->
        _mocks()
        _inject()

    beforeEach ->
        module "taigaProjects"

        _setup()

    it "fetch projects", (done) ->
        service.setToken(123)
        mocks.resources.asanaImporter.listProjects.withArgs(123).promise().resolve('projects')

        service.fetchProjects().then () ->
            service.projects = "projects"
            done()

    it "fetch user", (done) ->
        service.setToken(123)
        projectId = 3
        mocks.resources.asanaImporter.listUsers.withArgs(123, projectId).promise().resolve('users')

        service.fetchUsers(projectId).then () ->
            service.projectUsers = 'users'
            done()

    it "import project", () ->
        service.setToken(123)
        projectId = 2

        service.importProject(projectId, true, true ,true)

        expect(mocks.resources.asanaImporter.importProject).to.have.been.calledWith(123, projectId, true, true, true)

    it "get auth url", (done) ->
        service.setToken(123)
        projectId = 3

        response = {
            data: {
                url: "url123"
            }
        }

        getAuthUrlDeferred = $q.defer()
        mocks.resources.asanaImporter.getAuthUrl.returns(getAuthUrlDeferred.promise)
        getAuthUrlDeferred.resolve(response)

        service.getAuthUrl().then (url) ->
            expect(url).to.be.equal("url123")
            done()

        $rootScope.$apply()

    it "authorize", (done) ->
        service.setToken(123)
        projectId = 3
        verifyCode = 12345

        response = {
            data: {
                token: "token123"
            }
        }

        authorizeDeferred = $q.defer()
        mocks.resources.asanaImporter.authorize.withArgs(verifyCode).returns(authorizeDeferred.promise)
        authorizeDeferred.resolve(response)

        service.authorize(verifyCode).then (token) ->
            expect(token).to.be.equal("token123")
            done()

        $rootScope.$apply()
