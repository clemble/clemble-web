require './entities/RegistrationBaseEntities'
require './show/RegistrationBaseShow'

@App.module "RegistrationApp.RegistrationBaseApp", (RegistrationBaseApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false