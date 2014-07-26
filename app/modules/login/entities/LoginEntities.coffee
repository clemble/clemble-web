@App.module "LoginApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Login extends Backbone.Model
		default:
			email: null
			password: null

	API =
		new: () ->
			login = new Login()
			login.on "all", (evt) -> console.log(evt) # TODO make a single point to intercept all initiations, and listen for events
			login

	App.reqres.setHandler 'login:entities:new', () -> API.new()
