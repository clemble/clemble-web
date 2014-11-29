@App.module "RegistrationBaseApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		registerManual: (region) ->
			registration = App.request 'registration:base:entities:new'
			layout = new RegistrationLayout
				model: registration

			layout.on 'show', () ->

				App.request "registration:social:show", layout.social

				signIn = App.request 'registration:login:show:signIn', layout.signIn
			region.show layout

	class RegistrationLayout extends Marionette.LayoutView
		template: require "./templates/layout"
		behaviors:
			DisplayError: {}
		regions:
			signIn   : '#signIn'
			social   : '#social'

	App.reqres.setHandler 'registration:show', (region) -> Controller.registerManual(region)
