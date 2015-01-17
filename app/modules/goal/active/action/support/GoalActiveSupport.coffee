@App.module "GoalActiveActionApp.GoalActiveActionBid", (GoalActiveActionBid, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	Controller =
		showModal: (configuration) ->
			roleModal = new GoalSupporterModal
				model: configuration

			App.modal.show roleModal

	class GoalSupporterModal extends Marionette.LayoutView
		template: require "./templates/goal_support_modal"
		regions:
			configurationRegion : "#configurationRegion"
		behaviors: {
			MarionetteModal: {}
		}
		events:
			'click #go' : 'go'
		go: () =>
			self = @
			url = App.Utils.toUrl("/management/active/#{@model.get('goalKey')}/action")
			$.ajax({
				type: 'POST',
				url: url,
				data: JSON.stringify({ type: "player:bid:action"}),
				contentType: "application/json",
				success: () ->
					self.trigger("modal:close")
				dataType: 'json'
			})


	App.reqres.setHandler "goal:active:action:support:modal", (configuration) -> Controller.showModal(configuration)


