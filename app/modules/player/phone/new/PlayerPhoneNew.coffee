@App.module "PlayerPhoneApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		newPhone: () ->
			newPhone = App.request "player:phone:entities:new"
			newPhoneView = new PlayerPhone
				model: newPhone
			App.modal.show newPhoneView

	class PlayerPhone extends Marionette.ItemView
		template: require './templates/player_phone_new'
		behaviors:
			StickIt: {}
			StickValidation: {}
			MarionetteModal: {}
		bindings:
			'#phone' : 'phone'
		events:
			'click #next' : 'next'
		next: () =>
			view = @
			@model.save(@model.toJSON(),
				success: () ->
					view.trigger("modal:close")
			)
		onRender: () ->
			@$("#phone").intlTelInput({
				defaultCountry: "auto"
			})


	App.reqres.setHandler "player:phone:new:modal", () -> Controller.newPhone()