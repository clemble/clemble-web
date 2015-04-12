@App.module "PlayerPhoneApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class PlayerPhone extends Backbone.Model
		default:
			phone: null

	class PlayerPhoneVerify extends Backbone.Model
		default:
			code: null


	API =
		newPhone: () ->
			phone = new PlayerPhone()
			phone.url = App.Utils.toUrl("phone", "my")
			phone
		newPhoneVerify: () ->
			phone = new PlayerPhoneVerify()
			phone.url = App.Utils.toUrl("phone", "my/verify")
			phone

	App.reqres.setHandler "player:phone:entities:new", () -> API.newPhone()
	App.reqres.setHandler "player:phone:entities:new:verify", () -> API.newPhoneVerify()