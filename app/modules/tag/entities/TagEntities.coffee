@App.module "TagApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class ClembleTag extends Backbone.Model
		defaults:
			tag: null,
			power: null
		idAttribute:
			'tag'

	class ClembleTags extends Backbone.Collection
		model: ClembleTag

	API =
		myTags: () ->
			myTags = new ClembleTags()
			myTags.url = App.Utils.toUrl("/tag/my")
			myTags.fetch()
			myTags
		getTags: (player) ->
			playerTags = new ClembleTags()
			playerTags.url = App.Utils.toUrl("/tag/#{player}")
			playerTags.fetch()
			playerTags

	App.reqres.setHandler "tag:entities:my", () -> API.myTags()
	App.reqres.setHandler "tag:entities:player", (player) -> API.getTags(player)
