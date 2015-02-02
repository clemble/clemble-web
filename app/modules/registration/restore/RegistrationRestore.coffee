@App.module "RegistrationApp.Restore", (Restore, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (region) ->
			m = new RegistrationRestore
			restoreView = new RegistrationRestoreView
				model: m
			m.on "all", (evt) -> console.log("#{evt}")
			region.show restoreView
		showSuccess: (region) ->
			restoreSendView = new RegistrationRestoreSuccessView
			region.show restoreSendView

	class RegistrationRestore extends Backbone.Model
		default:
			email : null
		url : () -> App.Utils.toUrl "/registration/restore"

	class RegistrationRestoreView extends Marionette.ItemView
		template: require './templates/registration_restore'
		behaviors:
			StickIt         : {}
			StickValidation : {}
			DisplayError    : {}
		bindings:
			'#email'        : 'email'
		events:
			'click #restore' : () ->
				@model.save(@model.attributes, {
					success: () ->
						Backbone.history.navigate("#registration/restore/success", {trigger: true})
				})

	class RegistrationRestoreSuccessView extends Marionette.ItemView
		template: require './templates/registration_restore_success'

	App.reqres.setHandler "registration:restore:show", (region) -> Controller.show(region)
	App.reqres.setHandler "registration:restore:show:success", (region) -> Controller.showSuccess(region)
