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
	])

	associateCollection = (collection, nav) ->
		nav.listenTo collection, "sync", () -> nav.set('count', collection.length)
		nav.listenTo collection, "add", () -> nav.set('count', collection.length)
		nav.listenTo collection, "remove", () -> nav.set('count', collection.length)
		nav.listenTo collection, "reset", () -> nav.set('count', collection.length)

	SUGGESTION = new Navigation({
		name: 'Suggestion',
		icon: 'fa fa-lightbulb-o',
		url: 'suggestion',
		active: false
	})
	SUGGESTIONS = App.request("goal:suggestion:entities:list:my")
	NAVIGATIONS.add(SUGGESTION)
	associateCollection(SUGGESTIONS, SUGGESTION)

	NOTIFICATION = new Navigation({
		name: 'Notification',
		icon: 'fa fa-bell',
		url: 'notification',
		active: false
	})
	NOTIFICATIONS = App.request "notification:entities:my"
	NAVIGATIONS.add(NOTIFICATION)
	associateCollection(NOTIFICATIONS, NOTIFICATION)

	API =
		getNavigations: ->
			NAVIGATIONS
		updateActive: (url) ->
			NAVIGATIONS.forEach (header) ->
				header.set('active', _.str.startsWith(url.substring(1), header.get('url')))

	Backbone.history.bind "all", () ->
		API.updateActive(window.location.hash)

	App.reqres.setHandler "navigation:entities:all", -> API.getNavigations()