@App.module "RegistrationLoginApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (region, login) ->
			newLogin = new Login
				model: login
			region.show newLogin
			login
		signIn: (region) ->
			login = App.request "registration:login:entities:new"
			loginView = new LoginSignIn
				model: login
			region.show loginView
			login

	class Login extends Marionette.ItemView
		template: require './templates/login'
		bindings:
			'#emailOrNickName'  : 'emailOrNickName',
			'#password'         : 'password'
		behaviors:
			StickIt         : {}
			StickValidation : {}
			DisplayError    : {}
			SaveOnTextEnter: {}

	class LoginSignIn extends Login
		template: require './templates/signIn'
		events:
			'click #signIn': () -> @model.save()
#		behaviors:


	App.reqres.setHandler 'registration:login:show:new', (region, login) -> Controller.new(region, login)
	App.reqres.setHandler 'registration:login:show:signIn', (region) -> Controller.signIn(region)
