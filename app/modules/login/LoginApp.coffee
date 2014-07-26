require './entities/LoginEntities'
require './new/LoginNew'

@App.module "LoginApp", (LoginApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false