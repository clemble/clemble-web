@App.module "RegistrationApp.Restore", (Restore, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (region) ->
			restore = new RegistrationRestore()
			region.show restore

	class RegistrationRestore extends Marionette.ItemView
		template: require './templates/registration_restore'

	App.reqres.setHandler "registration:restore:show", (region) -> Controller.show(region)
