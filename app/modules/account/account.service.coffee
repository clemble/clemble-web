AccountService = ($resource) ->
	$resource(App.Utils.toUrl('payment', 'account/:player'), { player: '@id' })

angular.
	module('cl.account').
	service("AccountService", AccountService)


#	MY = new Account({player: 'my'})
#	App.on "payment:complete:my", (t) ->
#		# Copying account
#		MY.set(t.account)
#	App.on "payment:freeze:my", (t) ->
#    API.update(MY, "Credit", t.amount)
#	App.on "payment:bonus:my", (t) ->
#    API.update(MY, "Debit", t.amount)
#	MY.fetch()