# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.addRegions
		mainRegion:   "#main-region"

	App.addInitializer ->

	App.on "start", ->

		if Backbone.history
			Backbone.history.start()

	App
