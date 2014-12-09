@App.module "PlayerPhoneApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		newPhone: () ->
			layout = new PlayerPhoneLayout()
			layout.on "show", () ->
				newPhone = App.request "player:phone:entities:new"
				newPhoneView = new PlayerPhone
					model: newPhone
				layout.phoneApp.show newPhoneView

				newPhoneVerify = App.request "player:phone:entities:new:verify"
				newPhoneVerifyView = new PlayerPhoneVerification
					model: newPhoneVerify
				layout.verificationApp.show newPhoneVerifyView
			App.modal.show layout
		newPhoneVerify: () ->


	class PlayerPhoneLayout extends Marionette.LayoutView
		template: require './templates/player_phone_layout'
		regions:
			phoneApp         : "#phoneApp"
			verificationApp  : "#verificationApp"


	class PlayerPhone extends Marionette.ItemView
		template: require './templates/player_phone_new'
		behaviors:
			StickIt: {}
			StickValidation: {}
			MarionetteModal: {}
		bindings:
			'#phone' : 'phone'
		events:
			'click #add' : 'add'
		add: () =>
			@model.save()
		onRender: () ->
			@$("#phone").intlTelInput({
				defaultCountry: "auto"
			})

	class PlayerPhoneVerification extends Marionette.ItemView
		template: require './templates/player_phone_verify'
		behaviors:
			StickIt: {}
			StickValidation: {}
			MarionetteModal: {}
		bindings:
			'#code' : 'code'
		events:
			'click #verify' : 'verify'
		verify: () =>
			view = @
			@model.save(@model.toJSON(),
				success: () ->
					view.$el.parent().parent().parent().parent().parent().parent().parent().modal("hide")
			)


	App.reqres.setHandler "player:phone:new:modal", () -> Controller.newPhone()