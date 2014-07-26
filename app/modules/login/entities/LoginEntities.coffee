@App.module "LoginApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Login extends Backbone.Model
		default:
			email: null
			password: null

	API =
		new: () -> new Login()

	App.reqres.setHandler 'login:entities:new', () -> API.new()
