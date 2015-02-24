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

	MY = new Posts()
	MY.url = App.Utils.toUrl("/feed/my")
	App.on "post", (t) ->
		post = new Post(API.getId(t))
		MY.remove(post.get("key"))
		MY.add(post, {at : 0})
	MY.fetch()
	App.once "registered", () -> MY.fetch()

	API=
		getId: (res) ->
			if (res.state.bank?)
				myBet = _.find(res.state.bank.bets, (bet) -> bet.player == PLAYER)
				if (myBet?)
					res.state.myBet = myBet.bet
			res
		listMy: () ->
			MY
		listByPlayer: (player) ->
			if (player == 'my')
				API.listMy()
			else
				feed = new Posts()
				feed.url = App.Utils.toUrl("/feed/#{player}")
				feed.fetch()
				feed

	App.reqres.setHandler "feed:entities:my", () -> API.listMy()
	App.reqres.setHandler "feed:entities:player", (player) -> API.listByPlayer(player)