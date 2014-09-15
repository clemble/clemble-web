@App.module "GoalConstructionApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (configurations, region) ->
			layout = new GoalConstructionNewLayout
			layout.on "show", () ->
				App.request "goal:configuration:list", configurations, layout.configurationRegion
				constructionRequest = App.request "goal:construction:entities:new", configurations
				constructionRequestView = new GoalConstructionNew
					model: constructionRequest
				layout.goalRegion.show constructionRequestView
			region.show layout

	class GoalConstructionNewLayout extends Marionette.LayoutView
		template: require "./templates/goal_construction_new_layout"
		regions:
			goalRegion          : "#goalRegion",
			configurationRegion : "#configurationRegion"

	class GoalConstructionNew extends Marionette.ItemView
		template: require './templates/goal_construction_new'
		behaviors:
			StickIt: {}
		bindings:
			'#goal'       : 'goal'




	App.reqres.setHandler "goal:construction:new", (configurations, region) -> Controller.new(configurations, region)
