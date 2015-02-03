@App.module "TagApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		myTags: (region) ->
			myTags = App.request "tag:entities:my"
			myTagsView = new ClembleTags
				collection: myTags
			region.show myTagsView
		showTags: (player, region) ->
			tags = App.request "tag:entities:player", player
			tagsView = new ClembleTags
				collection: tags
			region.show tagsView

	class ClembleTag extends Marionette.ItemView
		template: require './templates/tag'

	class ClembleTags extends Marionette.CompositeView
		template: require './templates/tags'
		childView: ClembleTag
		childViewContainer : "#caption"
		modelEvents:
			"sync"  : "render"
			"change": "render"

	App.reqres.setHandler "tag:show:my", (region) -> Controller.myTags(region)