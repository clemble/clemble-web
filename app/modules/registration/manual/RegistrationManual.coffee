@App.module "RegistrationApp.Manual", (Manual, App, Backbone, Marionette, $, _) ->

	Controller =
		registerManual: (region) ->
			layout = new RegistrationLayout()
			layout.on 'show', () ->
				App.request 'login:new', layout.login
				manual = new RegistrationManual()
				layout.profile.show manual
			region.show layout

	class RegistrationManual extends Marionette.ItemView
		template: require './templates/manual'
		modelEvents:
			'change' : 'render'

	class RegistrationLayout extends Marionette.LayoutView
		template: require "./templates/layout"
		regions:
			login    : "#login"
			profile  : "#profile"

	App.reqres.setHandler 'registration:manual', (region) -> Controller.registerManual(region)
