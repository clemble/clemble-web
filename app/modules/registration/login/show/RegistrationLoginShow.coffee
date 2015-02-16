@App.module "RegistrationLoginApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		signIn: (region) ->
			login = App.request "registration:login:entities:new"
			loginView = new LoginSignIn
				model: login
			region.show loginView
			login

	class LoginSignIn extends Marionette.ItemView
		template: require './templates/signIn'
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
