# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.player = $.cookie("player")

	App.Utils =
		toUrl: (sub, url) -> "http://#{sub}.#{window.location.host}/#{url}"

	App.addRegions
		contentRegion : "#contentRegion"
		experimentRegion: "#experimentRegion"
		navigationRegion : "#navigationRegion"

		modal         : Marionette.ModalRegion

	App.addInitializer ->

	App.on "start", ->

		if Backbone.history
			Backbone.history.start()

		if ($.cookie("player")?)
			App.trigger("registered")
		else
			window.location = '#registration'

	App.on "registered", () ->
		App.request "connection:invitation:show", App.experimentRegion
		window.location = '#goal'
		App.request "navigation:list", App.navigationRegion

	$(window).bind('hashchange', () ->
		App.vent.trigger("hash:change", window.location.hash)
	);

	App
