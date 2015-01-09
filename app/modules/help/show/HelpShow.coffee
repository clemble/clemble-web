@App.module "HelpShow", (HelpShow, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	Controller =
		showHelp: (region) ->
			helpView = new HelpShow()
			region.show helpView

	class HelpShow extends Marionette.ItemView
		template: require './templates/help'

	App.reqres.setHandler "help:show", (region) -> Controller.showHelp(region)