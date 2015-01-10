# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.player = $.cookie("player")

	App.Utils =
		toUrl: (url) -> "http://api.#{window.location.host}#{url}"

	App.addRegions
		contentRegion : "#contentRegion"

		modal         : Marionette.ModalRegion

	App.addInitializer ->

	App.on "start", ->

		if Backbone.history
			Backbone.history.start()

		Backbone.history.navigate("goal", {trigger: true})

	App
