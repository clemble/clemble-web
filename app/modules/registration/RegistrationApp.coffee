require './manual/RegistrationManual'
require './entities/RegistrationEntities'

@App.module "RegistrationApp", (RegistrationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false