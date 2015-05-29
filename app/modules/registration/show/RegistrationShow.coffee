require './RegistrationShow.module'

@App.module "RegistrationBaseApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	App.reqres.setHandler 'registration:show', (region) -> AngularStarter.start(region, 'registration.signIn', require './registration')
	App.reqres.setHandler 'registration:show:manual', (region) -> AngularStarter.start(region, 'registration.signIn', require './registration_manual')
