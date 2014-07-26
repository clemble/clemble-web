require './entities/LoginEntities'
require './show/LoginShow'

@App.module "LoginApp", (LoginApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false