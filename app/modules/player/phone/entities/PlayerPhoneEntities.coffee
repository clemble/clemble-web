@App.module "PlayerPhoneApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class PlayerPhone extends Backbone.Model
		default:
			area: null
			phone: null

	API =
		newPhone: () ->
			phone = new PlayerPhone()
			phone.url = App.Utils.toUrl("/phone/my")
			phone

	App.reqres.setHandler "player:phone:entities:new", () -> API.newPhone()