# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.host = "localhost:8080"

	App.addRegions
		headerRegion  : "#headerRegion"
		mainRegion    : "#mainRegion"
		moneyRegion   : "#moneyRegion"

	App.addInitializer ->

	App.on "start", ->

		Backbone.on("all", (evt) -> console.log("Event"))

#		App.request "goal:pending:my", App.mainRegion
		App.request "header:list", App.headerRegion
#		App.request "player:account:show:my", App.moneyRegion

		if Backbone.history
			Backbone.history.start()

	App
