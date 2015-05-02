@App.module "SettingsSocialApp.List", (List, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class SocialConnections extends Marionette.ItemView
		template: require './templates/social_connections'
		modelEvents:
			"change" : "render"
		events:
			"click [signin]" : "socialLogin"
			'click #phone' : () -> App.request "player:phone:new:modal"
		socialLogin: (evt) =>
			signin = evt.currentTarget.getAttribute("signin")
			@$("##{signin}").submit()

	Controller =
		listMy: (region) ->
			profile = App.request("profile:entities:my")
			socialConnections = new SocialConnections
				model: profile
			region.show socialConnections

	App.reqres.setHandler "settings:social:list:my", (region) -> Controller.listMy(region)