require './social/PlayerSocialApp'
require './profile/PlayerProfileApp'
require './account/PlayerAccountApp'
require './connection/PlayerConnectionApp'
require './phone/PlayerPhoneApp'

@App.module "PlayerApp", (PlayerApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false