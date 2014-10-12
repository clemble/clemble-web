# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.host = "localhost:8080"

	App.addRegions
		headerRegion  : "#headerRegion"
		mainRegion    : "#mainRegion"
		profileApp    : "#profileApp"
		accountApp    : "#accountApp"
		modal         : Marionette.ModalRegion

	App.addInitializer ->

	App.on "start", ->

		Backbone.on("all", (evt) -> console.log("Event"))

		App.request "header:list", App.headerRegion
		App.request "player:profile:show:my", App.profileApp
		App.request "player:account:show:my", App.accountApp
		App.request "goal:pending:list:my", App.mainRegion

		if Backbone.history
			Backbone.history.start()

	App
