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

				layout.helpRegion.show new GoalConstructionHelp()
				layout.goalRegion.show constructionRequestView

			region.show layout
		newModal: (configurations) ->
			constructionRequest = App.request "goal:construction:entities:new", configurations
			layout = new GoalConstructionNewModal
				model: constructionRequest

			layout.on "show", () ->
				App.request "goal:configuration:list", configurations, layout.configurationRegion

				constructionRequestView = new GoalConstructionNew
					model: constructionRequest

				layout.helpRegion.show new GoalConstructionHelp()
				layout.goalRegion.show constructionRequestView

			App.modal.show layout
		newChoiceModal: (choice) ->
			constructionRequest = App.request "goal:construction:entities:new:choice", choice
			layout = new GoalConstructionNewModal
				model: constructionRequest

			layout.on "show", () ->
				App.request "goal:configuration:choice", choice, layout.configurationRegion

				constructionRequestView = new GoalConstructionNew
					model: constructionRequest

				layout.goalRegion.show constructionRequestView

			App.modal.show layout
		newInterval: (interval, region) ->
			constructionRequest = App.request "goal:construction:entities:new:interval", interval
			layout = new GoalConstructionNewLayout
				model: constructionRequest
			layout.on "show", () ->
				layout.refresh()
			region.show layout

		newIntervalModal: (interval) ->
			constructionRequest = App.request "goal:construction:entities:new:interval", interval
			layout = new GoalConstructionNewModal
				model: constructionRequest

			layout.on "show", () ->
				App.request "goal:configuration:interval", interval, layout.configurationRegion

				constructionRequestView = new GoalConstructionNew
					model: constructionRequest

				layout.goalRegion.show constructionRequestView

			App.modal.show layout

	class GoalConstructionHelp extends Marionette.ItemView
		template: require './templates/goal_construction_help'

	class GoalConstructionNewLayout extends Marionette.LayoutView
		template: require "./templates/goal_construction_new_layout"
		regions:
			goalRegion          : "#goalRegion"
			helpRegion          : "#helpRegion"
			configurationRegion : "#configurationRegion"
		events:
			'click #save'       : "save"
		save: () ->
			self = @
			@model.save(@model.attributes, {
				success: () ->
					self.refresh()
			})
		refresh: () ->
			interval = App.request "goal:configuration:entities:interval"
			constructionRequest = App.request "goal:construction:entities:new:interval", interval
			@model = constructionRequest
			App.request "goal:configuration:interval:short", interval, @configurationRegion
			constructionRequestView = new GoalConstructionNew
				model: constructionRequest

			@goalRegion.show constructionRequestView



	class GoalConstructionNewModal extends Marionette.LayoutView
		template: require "./templates/goal_construction_new_modal"
		regions:
			goalRegion          : "#goalRegion"
			helpRegion          : "#helpRegion"
			configurationRegion : "#configurationRegion"
		behaviors: {
			MarionetteModal: {}
		}

	class GoalConstructionNew extends Marionette.ItemView
		template: require './templates/goal_construction_new'
		modelEvents:
			'invalid': (model, error) ->
				@$("#error").show()
				@$("#error").text(error)
			'error' :  (model, response) ->
				@$("#error").show()
				@$("#error").text(response.responseJSON[0].error.description)
		behaviors:
			StickIt: {}
		bindings: {
			'#goal'       : 'goal'
			'#reward'     : 'reward'
		}

	App.reqres.setHandler "goal:construction:new", (configurations, region) ->
		Controller.new(configurations, region)
	App.reqres.setHandler "goal:construction:new:modal", (configurations) ->
		Controller.new(configurations, App.modal)

	App.reqres.setHandler "goal:construction:my:new", (region) ->
		interval = App.request("goal:configuration:entities:interval")
		Controller.newInterval(interval, region)
	App.reqres.setHandler "goal:construction:my:new:modal", () ->
		interval = App.request("goal:configuration:entities:interval")
		Controller.newIntervalModal(interval)

