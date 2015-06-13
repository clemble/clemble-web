#require './entities/ProfileEntities'
#require './new/ProfileNew'
#require './show/ProfileShow'

require './profile.module'
require './profile.service'
require './profile.controller'
require './profile.directive'

@App.module "ProfileApp", (PlayerProfileApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			App.request "profile:show:my", App.contentRegion
		showProfile: (player) ->
			AngularStarter.start(App.contentRegion, 'cl.profile', require './profile')

	class Router extends Marionette.AppRouter
		appRoutes:
			'player/profile'  : 'showMy'
			'player/:profile' : 'showProfile'

	App.addInitializer ->
		new Router
			controller: API