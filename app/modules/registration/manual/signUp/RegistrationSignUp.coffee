require "./RegistrationSignUp.module"
require "./RegistrationSignUp.service"
require "./RegistrationSignUp.controller"
require "./RegistrationSignUp.directive"

@App.module "RegistrationApp.SignUp", (SignUp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
