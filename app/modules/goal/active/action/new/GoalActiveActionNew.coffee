@App.module "GoalActiveAction.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		newModal: (url) ->
			newActionEntities = App.request "goal:active:action:entities:new", url
			newAction = new GoalActiveAction
				model: newActionEntities
			App.modal.show newAction

	class GoalActiveAction extends Marionette.ItemView
		template: require "./templates/goal_active_new_modal"
		behaviors:
			StickIt: {}
			MarionetteModal: {}
		bindings:
			'#status'  : 'status'
		events:
			'click #reached'       : "reached"
		reached: () ->
			view = @
			model = @model
			model.set("type", "goal:management:reached")
			model.save(model.toJSON(), {
				success: () ->
					#TODO really ugly shit
					view.$el.parent().parent().parent().parent().modal("hide")
			})

	App.reqres.setHandler "goal:active:action:new:modal", (url) -> Controller.newModal(url)

