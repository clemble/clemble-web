@App.module "RegistrationApp.Manual", (Manual, App, Backbone, Marionette, $, _) ->

	Controller =
		registerManual: (region) ->
			registration = new RegistrationManual()
			region.show registration

	class RegistrationManual extends Marionette.ItemView
		template: require './templates/manual'
		modelEvents:
			'change' : 'render'

	App.reqres.setHandler 'registration:manual', (region) -> Controller.registerManual(region)
