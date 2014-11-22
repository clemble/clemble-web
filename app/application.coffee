# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.player = $.cookie("player")

	App.Utils =
		toUrl: (url) -> "http://api.#{window.location.host}#{url}"

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

		App.on "all", (event) -> console.log("#{event}")

	App
