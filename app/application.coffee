# The application object.
@App = do(Marionette, Backbone) ->
	App = new Marionette.Application

	App.player = $.cookie("player")

	App.Utils =
		toUrl: (url) -> "http://api.#{window.location.host}#{url}"
		toSubdomainUrl: (sub, url) ->"http://#{sub}.#{window.location.host}#{url}"

	App.addRegions
		contentRegion : "#contentRegion"
		navigationRegion : "#navigationRegion"

		modal         : Marionette.ModalRegion

	App.addInitializer ->

	App.on "start", ->

		if Backbone.history
			Backbone.history.start()

		App.request "navigation:list", App.navigationRegion

	$(window).bind('hashchange', () ->
		App.vent.trigger("hash:change", window.location.hash)
	);

	App
