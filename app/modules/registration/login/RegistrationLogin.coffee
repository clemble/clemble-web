require "./RegistrationLogin.module"
require "./RegistrationLogin.service"
require "./RegistrationLogin.controller"

@App.module "RegistrationApp.Login", (Login, App, Backbone, Marionette, $, _) ->

	App.reqres.setHandler 'registration:login:show:signIn', (region) -> AngularStarter.start(region, 'registration.login', require './templates/login')
