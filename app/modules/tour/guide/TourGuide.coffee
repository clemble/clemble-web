@App.module "TourApp.Guide", (Guide, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		guide: () ->
			console.log("Guide")

	App.reqres.setHandler "tour:guide", () -> API.guide()