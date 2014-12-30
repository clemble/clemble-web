@App.module "FeedApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	PLAYER = App.player

	class Post extends Backbone.Model
		defaults:
			player : null
		parse: (res) ->
			API.getId(res)

	class Posts extends Backbone.Collection
		model: Post

	API=
		getId: (res) ->
			if (res.goalKey?)
				res.id = res.goalKey
			if (res.bank?)
				myBid = _.find(res.bank.bids, (bid) -> bid.player == PLAYER)
				if (myBid?)
					res.my = true
					res.myBid = myBid.bid
			res
		listMy: () ->
			feed = new Posts()
			feed.url = App.Utils.toUrl("/feed/my")
			App.on "post post:my", (t) ->
				post = new Post(API.getId(t))
				feed.remove(post.get("id"))
				feed.add(post, {at : 0})
			feed.fetch()
			feed

	App.reqres.setHandler "feed:entities:my", () -> API.listMy()