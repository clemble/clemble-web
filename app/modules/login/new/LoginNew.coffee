@App.module "LoginApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (region) ->
			model = App.request "login:entities:new"
			newLogin = new Login
				model: model
			region.show newLogin

	class Login extends Marionette.ItemView
		template: require './templates/login'
		bindings:
			'#email'    : 'email',
			'#password' : 'password'
		behaviors:
			StickIt:{}


	App.reqres.setHandler 'login:new', (region) -> Controller.new(region)
