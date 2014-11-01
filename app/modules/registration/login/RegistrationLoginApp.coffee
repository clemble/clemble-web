require './entities/RegistrationLoginEntities'
require './show/RegistrationLoginShow'

@App.module "RegistrationApp.RegistrationLoginApp", (RegistrationLoginApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false