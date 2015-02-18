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
			if (res.state.bank?)
				myBet = _.find(res.state.bank.bets, (bet) -> bet.player == PLAYER)
				if (myBet?)
					res.state.myBet = myBet.bet
			res
		listMy: () ->
			feed = new Posts()
			feed.url = App.Utils.toUrl("/feed/my")
			App.on "post", (t) ->
				console.log("My feed event POST")
				post = new Post(API.getId(t))
				feed.remove(post.get("key"))
				feed.add(post, {at : 0})
			feed.on "all", (event) -> console.log("My feed event #{event}")
			feed.fetch()
			feed
		listByPlayer: (player) ->
			feed = new Posts()
			feed.url = App.Utils.toUrl("/feed/#{player}")
			App.on "post", (t) ->
				if (t.player == player)
					post = new Post(API.getId(t))
					feed.remove(post.get("id"))
					feed.add(post, {at : 0})
			feed.fetch()
			feed

	App.reqres.setHandler "feed:entities:my", () -> API.listMy()
	App.reqres.setHandler "feed:entities:player", (player) -> API.listByPlayer(player)