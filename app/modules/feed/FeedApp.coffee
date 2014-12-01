require './list/FeedList'
require './entities/FeedEntities'

@App.module "FeedApp", (FeedApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false