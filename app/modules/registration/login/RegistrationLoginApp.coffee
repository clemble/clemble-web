require './entities/RegistrationLoginEntities'
require './show/RegistrationLoginShow'

@App.module "RegistrationLoginApp", (RegistrationLoginApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false