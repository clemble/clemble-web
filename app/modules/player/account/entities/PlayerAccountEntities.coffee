@App.module "PlayerAccountApp", (PlayerAccountApp, App, Backbone, Marionette, $, _) ->

	class PlayerAccount extends Backbone.Model
		defaults:
			player: null,
			cash: null
		idAttribute:
			'player'

	API =
		update: (account, operation, amount) ->
			money = account.get("money")
			if (operation == "Debit")
				money[amount.currency].amount = money[amount.currency].amount + amount.amount
			else if (operation == "Credit")
				money[amount.currency].amount = money[amount.currency].amount - amount.amount
			account.trigger("change")
		get: (player) ->
			account = new PlayerAccount(player: player)
			account.urlRoot = App.Utils.toUrl("/payment/account/")
			App.on "payment:complete:my", (t) ->
 				API.update(account, t.operation, t.amount)
			App.on "payment:freeze:my", (t) ->
 				API.update(account, "Credit", t.amount)
			App.on "payment:bonus:my", (t) ->
 				API.update(account, "Debit", t.amount)
			account.on "all", (evt) -> console.log("account > #{evt}")
			account.fetch()
			account

	App.reqres.setHandler "player:account:entities:my", () -> API.get('my')
	App.reqres.setHandler "player:account:entities:get", (player) -> API.get(player)