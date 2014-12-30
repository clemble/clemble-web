@App.module "GoalActiveActionApp.GoalActiveActionBid", (GoalActiveActionBid, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	Controller =
		showModal: (configuration) ->
			roleModal = new GoalObserverModal
				model: configuration

			App.modal.show roleModal

	class GoalObserverModal extends Marionette.LayoutView
		template: require "./templates/goal_observe_modal"
		regions:
			configurationRegion : "#configurationRegion"
		behaviors: {
			MarionetteModal: {}
		}
		events:
			'click #go' : 'go'
		go: () =>
			self = @
			url = App.Utils.toUrl("/construction/initiation/#{@model.get('goalKey')}/bid")
			$.ajax({
				type: 'POST',
				url: url,
				data: JSON.stringify("observer"),
				contentType: "application/json",
				success: () ->
					self.trigger("modal:close")
				dataType: 'json'
			})


	App.reqres.setHandler "goal:active:action:observe:modal", (configuration) -> Controller.showModal(configuration)


