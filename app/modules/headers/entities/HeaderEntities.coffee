@App.module "HeaderApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Header extends Backbone.Model
		default:
			name: null,
			icon: null,
			url: null

	class HeaderCollection extends Backbone.Collection
		model:
			Header

	headers = new HeaderCollection([
		{name: 'Goals', icon: 'fa fa-bullseye', url: 'goal', active: true}
		{name: 'Profile', icon: 'fa fa-user', url: 'player/profile', active: false}
		{name: 'Account', icon: 'fa fa-credit-card', url: 'player/account', active: false}
	])

	API =
		getHeaders: ->
			headers
		updateActive: (url) ->
			headers.forEach (header) ->
				header.set('active', _.str.startsWith(url.substring(1), header.get('url')))

	Backbone.history.bind "all", (route) ->
		API.updateActive(window.location.hash)

	App.reqres.setHandler "header:entities", -> API.getHeaders()
