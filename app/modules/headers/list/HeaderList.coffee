@App.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->

	Controller =
		list: (region) ->
			layout = new NavigationLayout()
			layout.on "show", () ->

				headers = App.request 'header:entities'
				headersView = new Navigations
					collection: headers
				layout.navigationApp.show headersView

				controlView = new NavigationControl()
				layout.controlApp.show controlView
			region.show layout

	class Navigation extends Marionette.ItemView
		template: require './templates/navigation'
		tagName: 'li'
		modelEvents:
			'change:active': 'applyActive'
		events:
			'click': () -> @model.set('active', true)
		render: () ->
			@applyActive()
			super
		applyActive:
			() -> $(this.el).toggleClass('active', @model.get('active'))

	class Navigations extends Marionette.CollectionView
		tagName: 'ul'
		className: 'nav navbar-nav'
		childView: Navigation
		collectionEvents:
			'change:active': (model) ->
				if (model.get("active"))
					@collection.forEach((m) -> if (m != model) then m.set("active", false))

	class NavigationLayout extends Marionette.LayoutView
		template  : require "./templates/navigation_layout"
		regions:
			navigationApp : "#navigation"
			controlApp    : "#control"

	class NavigationControl extends Marionette.ItemView
		template : require "./templates/navigation_control"
		events:
			"click #add": () -> App.request "goal:construction:my:new:modal"
			"click #connect": () -> App.request "player:connection:invitation:new:modal"

	App.reqres.setHandler "header:list", (region) -> Controller.list(region)
