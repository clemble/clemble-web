@App.module "RegistrationApp.Manual", (Manual, App, Backbone, Marionette, $, _) ->

	Controller =
		registerManual: (region) ->
			layout = new RegistrationLayout()
			layout.on 'show', () ->
				signIn = App.request 'login:show:signIn', layout.signIn
				login = App.request 'login:show:new', layout.login
				profile = App.request 'profile:new', layout.profile
				manual = new RegistrationManual()
				layout.control.show manual
			region.show layout

	class RegistrationManual extends Marionette.ItemView
		template: require './templates/manual'
		modelEvents:
			'change'  : 'render'
		events:
			'click #signUp' : 'singUp'
		singIn: () ->
			console.log("Sign In")


	class RegistrationLayout extends Marionette.LayoutView
		template: require "./templates/layout"
		regions:
			login    : '#login'
			profile  : '#profile'
			control  : '#control'
			signIn   : '#signIn'

	App.reqres.setHandler 'registration:manual', (region) -> Controller.registerManual(region)
