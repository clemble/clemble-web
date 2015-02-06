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
			goalList = new GoalNavigation()
			region.show(goalList)

	class RegistrationNavigation extends Marionette.ItemView
		template: require './templates/registration_navigation'

	class GoalNavigation extends Marionette.ItemView
		template: require './templates/goal_navigation'

	App.reqres.setHandler "navigation:list", (reg) -> Controller.list(reg)
