@App.module "GoalActiveAction.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		newModal: (url) ->
			newActionEntities = App.request "goal:active:action:entities:new", url
			newAction = new GoalActiveActionModal
				model: newActionEntities
			App.modal.show newAction

	class GoalActiveAction extends Marionette.ItemView
		template: require "./templates/goal_active_new"
		behaviors:
			StickIt: {}
		bindings:
			'#status'  : 'status'
		events:
			"click #update": () -> @model.save()

	class GoalActiveActionModal extends Marionette.ItemView
		template: require "./templates/goal_active_new_modal"
		behaviors:
			StickIt: {}
			MarionetteModal: {}
		bindings:
			'#status'  : 'status'

	App.reqres.setHandler "goal:active:action:new:modal", (url) -> Controller.newModal(url)

