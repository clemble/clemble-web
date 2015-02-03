require './entities/TagEntities'
require './show/TagShow'

@App.module "TagApp", (TagApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false