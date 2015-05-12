require "./RegistrationLogin.module"
require "./RegistrationLogin.service"
require "./RegistrationLogin.controller"

@App.module "RegistrationApp.Login", (Login, App, Backbone, Marionette, $, _) ->

	Controller =
		signIn: (region) ->
			login = App.request "registration:entities:login:new"
			loginView = new LoginSignIn
				model: login
			region.show loginView
			login

	class LoginSignIn extends Marionette.ItemView
		template: require './templates/login'
		onShow: () ->
			angular.bootstrap(@el, ['ngMessages', 'registration.login'])

	App.reqres.setHandler 'registration:login:show:signIn', (region) -> Controller.signIn(region)
