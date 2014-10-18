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
		newModal: (configurations) ->
			constructionRequest = App.request "goal:construction:entities:new", configurations
			layout = new GoalConstructionNewModal
				model: constructionRequest

			layout.on "show", () ->
				App.request "goal:configuration:list", configurations, layout.configurationRegion

				constructionRequestView = new GoalConstructionNew
					model: constructionRequest

				layout.goalRegion.show constructionRequestView

			App.modal.show layout


	class GoalConstructionNewLayout extends Marionette.LayoutView
		template: require "./templates/goal_construction_new_layout"
		regions:
			goalRegion          : "#goalRegion",
			configurationRegion : "#configurationRegion"
		events:
			'click #save'       : "save"
		save: () ->
			model = @model
			view = @
			model.save(model.toJSON(), {
					success: () ->
						view.trigger("close")
					error: (error) ->
						model.set("error", error)
				})

	class GoalConstructionNewModal extends Marionette.LayoutView
		template: require "./templates/goal_construction_new_modal"
		regions:
			goalRegion          : "#goalRegion",
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
				#TODO show all the errors not only the first one
				@$("#error").text(response.responseJSON[0].error.description)
		behaviors:
			StickIt: {}
		bindings: {
			'#goal': 'goal'
		}


	App.reqres.setHandler "goal:construction:new", (configurations, region) -> Controller.new(configurations, region)
	App.reqres.setHandler "goal:construction:new:modal", (configurations) -> Controller.new(configurations, App.modal)

	App.reqres.setHandler "goal:construction:my:new", (region) ->
		configurations = App.request("goal:configuration:entities:all")
		Controller.new(configurations, region)
	App.reqres.setHandler "goal:construction:my:new:modal", () ->
		configurations = App.request("goal:configuration:entities:all")
		Controller.newModal(configurations)
