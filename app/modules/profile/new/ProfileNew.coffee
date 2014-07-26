@App.module "ProfileApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (region) ->
			profile = App.request('profile:entities:new')
			profileView = new Profile
				model: profile
			region.show profileView

	class Profile extends Marionette.ItemView
		template: require './templates/profile'
		modelEvents:
			change : 'render'

	App.reqres.setHandler 'profile:new', (region) -> Controller.new(region)
