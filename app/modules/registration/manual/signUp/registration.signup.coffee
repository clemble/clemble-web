require "./registration.signup.module"
require "./registration.signup.service"
require "./registration.signup.controller"
require "./registration.signup.directive"

@App.module "RegistrationApp.SignUp", (SignUp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
