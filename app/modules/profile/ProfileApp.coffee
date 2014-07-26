require './entities/ProfileEntities'
require './new/ProfileNew'

@App.module "ProfileApp", (ProfileApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false