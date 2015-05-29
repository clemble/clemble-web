require './RegistrationReset.module'
require './RegistrationReset.service'
require './RegistrationReset.controller'
require './RegistrationReset.directive'

@App.module "RegistrationApp.Reset", (Reset, App, Backbone, Marionette, $, _) ->

	App.reqres.setHandler "registration:reset:show", (region, token) -> AngularStarter.start(region, 'registration.reset', require './tmp-registration-reset')
	App.reqres.setHandler "registration:reset:show:success", (region) -> AngularStarter.start(region, 'registration.reset', require './tmp-registration-reset-success')
