@App.module "PlayerAccountApp", (PlayerAccountApp, App, Backbone, Marionette, $, _) ->

	class PlayerAccount extends Backbone.Model
		defaults:
			player: null,
			cash: null
		idAttribute:
			'player'
		urlRoot:
			App.Utils.toUrl("payment", "account/")

	MY = new PlayerAccount({player: 'my'})
	App.on "payment:complete:my", (t) ->
		# Copying account
		MY.set(t.account)
	App.on "payment:freeze:my", (t) ->
    API.update(MY, "Credit", t.amount)
	App.on "payment:bonus:my", (t) ->
    API.update(MY, "Debit", t.amount)
	MY.fetch()

	App.on "registered", () -> MY.fetch()

	API =
		update: (account, operation, amount) ->
			money = account.get("money")
			if (operation == "Debit")
				money[amount.currency].amount = money[amount.currency].amount + amount.amount
			else if (operation == "Credit")
				money[amount.currency].amount = money[amount.currency].amount - amount.amount
			account.trigger("change")
		get: (player) ->
			if (player == 'my')
				MY
			else
				account = new PlayerAccount(player: player)
				account.on "all", (evt) -> console.log("account > #{evt}")
				account.fetch()
				account

	App.reqres.setHandler "player:account:entities:my", () -> API.get('my')
	App.reqres.setHandler "player:account:entities:get", (player) -> API.get(player)