@App.module "FeedApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	PLAYER = App.player

	class Post extends Backbone.Model
		defaults:
			player : null
		idAttribute:
			'key'
		urlRoot:
			'/feed/post/'
		parse: (res) ->
			API.getId(res)

	class Posts extends Backbone.Collection
		model: Post

	API=
		getId: (res) ->
			if (res.goalKey?)
				res.id = res.goalKey
			if (res.bank?)
				myBet = _.find(res.bank.bets, (bet) -> bet.player == PLAYER)
				if (myBet?)
					res.my = true
					res.myBet = myBet.bet
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