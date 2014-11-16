@App.module "PlayerAccountApp", (PlayerAccountApp, App, Backbone, Marionette, $, _) ->

	class PlayerAccount extends Backbone.Model
		defaults:
			player: null,
			cash: null
		idAttribute:
			'player'

	API =
		get: (player) ->
			account = new PlayerAccount(player: player)
			account.urlRoot = App.Utils.toUrl("/payment/account/")
			App.on "payment:complete", () -> account.fetch()
			App.on "payment:freeze", () -> account.fetch()
			account.fetch()
			account

	App.reqres.setHandler "player:account:entities:my", () -> API.get('my')
	App.reqres.setHandler "player:account:entities:get", (player) -> API.get(player)