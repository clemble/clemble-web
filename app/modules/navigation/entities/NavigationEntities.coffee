@App.module "NavigationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Navigation extends Backbone.Model
		default:
			name: null,
			icon: null,
			url: null

	class Navigations extends Backbone.Collection
		model:
			Navigation

	NAVIGATIONS = new Navigations([
		{name: 'Home', icon: 'fa fa-home', url: 'goal', active: true}
		{name: 'Suggestion', icon: 'fa fa-lightbulb-o', url: 'suggestion', active: false}
		{name: 'Notification', icon: 'fa fa-bell', url: 'notification', active: false}
	])

	API =
		getNavigations: ->
			NAVIGATIONS
		updateActive: (url) ->
			NAVIGATIONS.forEach (header) ->
				header.set('active', _.str.startsWith(url.substring(1), header.get('url')))

	Backbone.history.bind "all", () ->
		API.updateActive(window.location.hash)

	App.reqres.setHandler "navigation:entities:all", -> API.getNavigations()