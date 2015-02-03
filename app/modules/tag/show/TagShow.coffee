@App.module "TagApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		myTags: (region) ->
			myTags = App.request "tag:entities:my"
#			myTagsView = new ClembleTagCloud
#				model: myTags
#			region.show myTagsView
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
		modelEvents:
			"change"  : "render"

	class ClembleTags extends Marionette.CompositeView
		template: require './templates/tags'
		childView: ClembleTag
		childViewContainer : "#caption"
		modelEvents:
			"sync"    : "render"
			"change"  : "render"

	class ClembleTagCloud extends Marionette.ItemView
		template: require './templates/tag_cloud'
		modelEvents:
			"sync"    : "render"
			"change"  : "render"
		onRender: () ->
			tagCloud = @model.map((el) -> { text : el.get('tag'), weight : el.get('power') })
			@$('#caption').jQCloud(tagCloud, {
				autoResize: true
			});

	App.reqres.setHandler "tag:show:my", (region) -> Controller.myTags(region)