require "./RegistrationRestore.module"
require "./RegistrationRestore.service"
require "./RegistrationRestore.controller"
require "./RegistrationRestore.directive"

@App.module "RegistrationApp.Restore", (Restore, App, Backbone, Marionette, $, _) ->

	App.reqres.setHandler "registration:restore:show", (region) -> AngularStarter.start(region, 'registration.restore', require './tmp-registration-restore')
	App.reqres.setHandler "registration:restore:show:success", (region) -> AngularStarter.start(region, 'registration.restore', require './tmp-registration-restore-success')
