@App.module "PlayerSocialApp.List", (List, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class SocialConnections extends Marionette.ItemView
		template: require './templates/social_connections'
		modelEvents:
			"change" : "render"
		events:
			"click .btn" : "socialLogin"
			'click #phone' : () -> App.request "player:phone:new:modal"
			'click #email' : () -> App.request "player:email:new:modal"
		socialLogin: (evt) =>
			signin = evt.currentTarget.getAttribute("signin")
			@$("##{signin}").submit()

	Controller =
		listMy: (region) ->
			profile = App.request("player:profile:entities:my")
			socialConnections = new SocialConnections
				model: profile
			region.show socialConnections

	App.reqres.setHandler "player:social:list:my", (region) -> Controller.listMy(region)