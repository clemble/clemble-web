@App.module "NavigationApp.List", (List, App, Backbone, Marionette, $, _) ->

	region = null
	App.vent.on("hash:change", (location) ->
		console.log("Navigation triggered" + location)
		if (region?)
			Controller.listWithHash(location, region)
	)

	Controller =
		list: (reg) ->
			region = reg
			Controller.listWithHash(window.location.hash, region)

		listWithHash: (hash, region) ->
			if (hash.indexOf("#registration") != -1)
				console.log("Drawing registration")
				Controller.listRegistration(region)
			else
				console.log("Drawing goal")
				Controller.listGoal(region)

		listRegistration: (region) ->
			registrationList = new RegistrationNavigation()
			region.show(registrationList)

		listGoal: (region) ->
			navs = App.request "navigation:entities:all"
			goalList = new Navigations(
				collection: navs
			)
			region.show goalList

	class RegistrationNavigation extends Marionette.ItemView
		template: require './templates/registration_navigation'

#	class GoalNavigation extends Marionette.ItemView
#		template: require './templates/goal_navigation'
#
#	class GoalNavigationLayout extends Marionette.LayoutView
#		template: require './templates/goal_navigation'
#		regions:
#			suggestionApp       : "#suggestionApp"

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

	class Navigations extends Marionette.CompositeView
		template: require './templates/goal_navigation'
		childView: Navigation
		childViewContainer: '#menu'
		collectionEvents:
			'change:active': (model) ->
				if (model.get("active"))
					@collection.forEach((m) -> if (m != model) then m.set("active", false))

	App.reqres.setHandler "navigation:list", (reg) -> Controller.list(reg)
