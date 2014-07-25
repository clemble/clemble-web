# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.addRegions
		mainRegion:   "#main-region"

	App.addInitializer ->

	App.on "start", ->

		App.request "registration:manual", App.mainRegion

		if Backbone.history
			Backbone.history.start()

	App
