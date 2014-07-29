@App.module "RegistrationApp.Manual", (Manual, App, Backbone, Marionette, $, _) ->

	Controller =
		registerManual: (region) ->
			layout = new RegistrationLayout()
			layout.on 'show', () ->
				signIn = App.request 'login:show:signIn', layout.signIn
				login = App.request 'login:show:new', layout.login
				profile = App.request 'player:profile:new', layout.profile

				registration = App.request 'registration:entities:new', login, profile
				manual = new RegistrationControl
					model: registration
				layout.control.show manual
			region.show layout

	class RegistrationControl extends Marionette.ItemView
		template: require './templates/control'
		modelEvents:
			'change'  : 'render'
		events:
			'click #signUp' : 'singUp'
		singUp: () ->
			@model.save()


	class RegistrationLayout extends Marionette.LayoutView
		template: require "./templates/layout"
		regions:
			login    : '#login'
			profile  : '#profile'
			control  : '#control'
			signIn   : '#signIn'

	App.reqres.setHandler 'registration:manual', (region) -> Controller.registerManual(region)
