@App.module "GoalConstructionApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (configurations, region) ->
			constructionRequest = App.request "goal:construction:entities:new", configurations
			layout = new GoalConstructionNewLayout
				model: constructionRequest
			layout.on "show", () ->
				App.request "goal:configuration:list", configurations, layout.configurationRegion
				constructionRequestView = new GoalConstructionNew
					model: constructionRequest
				layout.goalRegion.show constructionRequestView
			region.show layout

	class GoalConstructionNewLayout extends Marionette.LayoutView
		template: require "./templates/goal_construction_new_layout"
		regions:
			goalRegion          : "#goalRegion",
			configurationRegion : "#configurationRegion"
		events:
			'click #save'       : () -> @model.save()

	class GoalConstructionNew extends Marionette.ItemView
		template: require './templates/goal_construction_new'
		behaviors:
			StickIt: {}
		bindings:
			'#goal'       : 'goal'


	App.reqres.setHandler "goal:construction:new", (configurations, region) -> Controller.new(configurations, region)
