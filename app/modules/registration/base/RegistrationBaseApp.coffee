require './entities/RegistrationBaseEntities'
require './show/RegistrationBaseShow'

@App.module "RegistrationBaseApp", (RegistrationBaseApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false