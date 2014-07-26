@App.module "LoginApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (region) ->
			login = App.request "login:entities:new"
			newLogin = new Login
				model: login
			region.show newLogin
			login

	class Login extends Marionette.ItemView
		template: require './templates/login'
		bindings:
			'#email'    : 'email',
			'#password' : 'password'
		behaviors:
			StickIt:{}


	App.reqres.setHandler 'login:new', (region) -> Controller.new(region)
