@App.module "PlayerPhoneApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		newPhone: (region) ->
			newPhone = App.request "player:phone:entities:new"
			newPhoneView = new PlayerPhone
				model: newPhone
			region.show newPhoneView

	class PlayerPhone extends Marionette.ItemView
		template: require './templates/player_phone_new'
		behaviors:
			StickIt: {}
			StickValidation: {}
		bindings:
			'#phone' : 'phone'
		events:
			'click #add' : 'add'
		add: () =>
			@model.save()
			console.log("#{JSON.stringify(@model)}")
		onShow: () ->
			@$("#phone").intlTelInput({
				defaultCountry: "auto"
			})


	App.reqres.setHandler "player:phone:new", (region) -> Controller.newPhone(region)