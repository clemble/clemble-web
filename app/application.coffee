# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.host = "localhost:8080"

	App.addRegions
		headerRegion  : "#headerRegion"
		contentRegion : "#contentRegion"

		modal         : Marionette.ModalRegion

	App.addInitializer ->

	App.on "start", ->

		Backbone.on("all", (evt) -> console.log("Event"))

		App.request "header:list", App.headerRegion
		App.request "goal:show:my", App.contentRegion

		if Backbone.history
			Backbone.history.start()

	App
