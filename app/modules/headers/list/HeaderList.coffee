@App.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->

	Controller =
		list: (region) ->
			headers = App.request 'header:entities'
			headersView = new Navigations
				collection: headers
			region.show headersView

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

	App.reqres.setHandler "header:list", (region) -> Controller.list(region)
