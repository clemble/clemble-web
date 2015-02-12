

@App.module "SettingsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	class SettingsShowLayout extends Marionette.LayoutView
		template: require './templates/settings_show'
		regions:
			socialConnectApp  : "#socialConnectApp"
			tagApp            : "#tagApp"

	Controller =
		show: (region) ->
			layout = new SettingsShowLayout()
			layout.on "show", () ->
				App.request "player:social:list:my", layout.socialConnectApp
				App.request "tag:show:my", layout.tagApp
				console.log("Showing layout")
			region.show layout



	App.reqres.setHandler "settings:show", (region) -> Controller.show(region)