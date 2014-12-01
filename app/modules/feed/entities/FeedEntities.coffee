@App.module "FeedApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	PLAYER = App.player

	class Post extends Backbone.Model
		defaults:
			player : null
		parse: (res) ->
			if (res.goalKey?)
				res.id = res.goalKey
			res

	class Posts extends Backbone.Collection
		model: Post

	API=
		listMy: () ->
			feed = new Posts()
			feed.url = App.Utils.toUrl("/feed/my")
			App.on "post", (t) ->
				feed.add(new Post(t), {at : 0})
			App.on "post:my", (t) ->
				feed.add(new Post(t), {at : 0})
			feed.fetch()
			feed

	App.reqres.setHandler "feed:entities:my", () -> API.listMy()