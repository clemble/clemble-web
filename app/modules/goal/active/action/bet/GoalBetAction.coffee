@App.module "GoalActiveActionApp.GoalBetAction", (GoalActiveActionBid, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	Controller =
		newBet: (goalKey, configuration) ->
			bet = App.request "goal:active:action:entities:bet", App.Utils.toUrl("management", "active/#{goalKey}/action")

			betModal = new GoalBetAction({
				model: bet
			})

			betRule = configuration.supporterConfiguration.betRule
			betModal.betOptions = {
				min: betRule.minBet,
				max: betRule.maxBet
			}

			percentage = 100 + configuration.supporterConfiguration.percentage

			bet.on "change:bet", (model) ->
				model.set('win', Math.round(model.get('bet') * percentage / 100))

			App.modal.show betModal

	class GoalBetAction extends Marionette.ItemView
		template: require './templates/bet_action_modal'
		behaviors:
			StickIt: {}
			MarionetteModal: {}
		bindings:
			'#bet': {
				observe: 'bet',
				sliderOptions: () ->
					range = @view.betOptions
					start = range.min
					options = {
						start: start,
						connect: "lower",
						range: range
					}
					options
			}
		modelEvents:
			'change'  : 'render'

	App.reqres.setHandler "goal:active:action:bet:modal", (goalKey, configuration) -> Controller.newBet(goalKey, configuration)