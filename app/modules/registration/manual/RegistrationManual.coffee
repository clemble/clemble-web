@App.module "RegistrationApp.Manual", (Manual, App, Backbone, Marionette, $, _) ->

	Controller =
		registerManual: (region) ->
			layout = new RegistrationLayout()
			layout.on 'show', () ->
				login = App.request 'login:new', layout.login
				profile = App.request 'profile:new', layout.profile
				manual = new RegistrationManual()
				layout.control.show manual
			region.show layout

	class RegistrationManual extends Marionette.ItemView
		template: require './templates/manual'
		modelEvents:
			'change'  : 'render'
		events:
			'click #signIn' : 'singIn'
		singIn: () ->
			console.log("Sign In")


	class RegistrationLayout extends Marionette.LayoutView
		template: require "./templates/layout"
		regions:
			login    : '#login'
			profile  : '#profile'
			control  : '#control'

	App.reqres.setHandler 'registration:manual', (region) -> Controller.registerManual(region)
