@App.module "LoginApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (region) ->
			login = App.request "login:entities:new"
			newLogin = new Login
				model: login
			region.show newLogin
			login
		signIn: (region) ->
			login = App.request "login:entities:new"
			loginView = new LoginSignIn
				model: login
			region.show loginView
			login

	class Login extends Marionette.ItemView
		template: require './templates/login'
		bindings:
			'#email'    : 'email',
			'#password' : 'password'
		behaviors:
			StickIt:{}

	class LoginSignIn extends Login
		template: require './templates/signIn'
		events:
			'click #signIn': () -> @model.save()


	App.reqres.setHandler 'login:show:new', (region) -> Controller.new(region)
	App.reqres.setHandler 'login:show:signIn', (region) -> Controller.signIn(region)
