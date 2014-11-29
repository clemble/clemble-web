@App.module "RegistrationSignUpApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		registerManual: (region) ->
			registration = App.request 'registration:base:entities:new'
			layout = new RegistrationLayout
				model: registration

			layout.on 'show', () ->

				App.request "registration:social:show", layout.social

				signIn = App.request 'registration:login:show:signIn', layout.signIn

				login = App.request 'registration:login:show:new', layout.login, registration.playerCredential
				profile = App.request 'player:profile:new', layout.profile, registration.playerProfile
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
		singUp: () =>
			view = @
			@model.save(@model.toJSON(), {
				success: () ->
					Backbone.history.navigate("goal", { trigger: true })
				error: () ->
					console.log("NO Error Processing for signUp failure")
			})

	class RegistrationLayout extends Marionette.LayoutView
		template: require "./templates/layout"
		behaviors:
			DisplayError: {}
		regions:
			login    : '#login'
			profile  : '#profile'
			control  : '#control'
			signIn   : '#signIn'
			social   : '#social'

	App.reqres.setHandler 'registration:signUp:show', (region) -> Controller.registerManual(region)
