# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.addRegions
		mainRegion:   "#main-region"

	App.addInitializer ->

	App.on "start", ->

		Backbone.on("all", (evt) -> console.log("Event"))

		App.request "registration:manual", App.mainRegion

		if Backbone.history
			Backbone.history.start()

	App
