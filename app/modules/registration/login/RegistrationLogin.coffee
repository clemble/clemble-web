@App.module "RegistrationApp.Login", (Login, App, Backbone, Marionette, $, _) ->

	Controller =
		signIn: (region) ->
			login = App.request "registration:entities:login:new"
			loginView = new LoginSignIn
				model: login
			region.show loginView
			login

	class LoginSignIn extends Marionette.ItemView
		template: require './templates/login'
		bindings:
			'#emailOrNickName'  : 'emailOrNickName',
			'#password'         : 'password'
		behaviors:
			StickIt         : {}
			StickValidation : {}
			DisplayError    : {}
			SaveOnTextEnter: {}
		events:
			'click #signIn': () -> @model.save()

	App.reqres.setHandler 'registration:login:show:signIn', (region) -> Controller.signIn(region)
