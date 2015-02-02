@App.module "RegistrationApp.Reset", (Reset, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (region, token) ->
			resetRequest = new RegistrationReset({ token: token})
			resetView = new RegistrationResetView
				model: resetRequest
			region.show resetView
		showSuccess: (region) ->
			resetView = new RegistrationResetSuccessView
			region.show resetView
			goHome = () -> Backbone.history.navigate("#registration", {trigger: true})
			window.setTimeout(goHome, 3000)


	class RegistrationReset extends Backbone.Model
		default:
			token     : null
			password  : null
		url : () -> App.Utils.toUrl "/registration/reset"

	class RegistrationResetView extends Marionette.ItemView
		template: require './templates/registration_reset'
		behaviors:
			StickIt         : {}
			StickValidation : {}
			DisplayError    : {}
		bindings:
			'#password'        : 'password'
		events:
			'click #reset' : () ->
				@model.save(@model.attributes, {
					success: () ->
						Backbone.history.navigate("#registration/reset/success", {trigger: true})
				})

	class RegistrationResetSuccessView extends Marionette.ItemView
		template: require './templates/registration_reset_success'



	App.reqres.setHandler "registration:reset:show", (region, token) -> Controller.show(region, token)
	App.reqres.setHandler "registration:reset:show:success", (region) -> Controller.showSuccess(region)
