@App.module "PlayerProfileApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (region) ->
			profile = App.request('player:profile:entities:new')
			profileView = new PlayerProfileNew
				model: profile
			region.show profileView
			profile

	class PlayerProfileNew extends Marionette.ItemView
		template: require './templates/profile'
		behaviors:
			StickIt: {}
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
			'#gender'   : 'gender'
			'#birthDate': 'birthDate'
		}


	App.reqres.setHandler 'player:profile:new', (region) -> Controller.new(region)
