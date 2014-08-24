require './entities/HeaderEntities'
require './list/HeaderList'

@App.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

