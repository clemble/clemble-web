require './entities/RegistrationSignUpEntities'
require './show/RegistrationSignUpShow'

@App.module "RegistrationSignUpApp", (RegistrationSignUpApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false