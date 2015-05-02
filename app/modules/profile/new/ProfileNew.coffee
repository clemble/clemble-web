@App.module "ProfileApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (region, profile) ->
			profileView = new PlayerProfileNew
				model: profile
			region.show profileView
			profile

	class PlayerProfileNew extends Marionette.ItemView
		template: require './templates/profile'
		behaviors:
			StickIt: {}
			StickValidation: {}
		bindings: {
			'#country'  : 'country'
			'#nickName' : 'nickName'
			'#fullName' :
				observe : ['firstName', 'lastName'],
				onGet   : (values) ->
					if (values[0]? && values[1])
						values[0] + ' ' + values[1]
					else
						''
				onSet   : (value) -> value.split(' ')
			'[name="gender"]'   : 'gender'
			'#birthDate': 'birthDate'
		}


	App.reqres.setHandler 'player:profile:new', (region, profile) -> Controller.new(region, profile)
