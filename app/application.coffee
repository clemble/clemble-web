# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.host = "localhost:8080"

	App.addRegions
		mainRegion:   "#main-region"

	App.addInitializer ->

	App.on "start", ->

		Backbone.on("all", (evt) -> console.log("Event"))

		App.request "goal:pending:my", App.mainRegion

		if Backbone.history
			Backbone.history.start()

	App
