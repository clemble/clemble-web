require './show/PlayerShow'
require './social/PlayerSocialApp'
require './profile/PlayerProfileApp'
require './phone/PlayerPhoneApp'

@App.module "PlayerApp", (PlayerApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false