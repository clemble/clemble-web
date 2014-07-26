@App.module "ProfileApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (region) ->
			profile = App.request('profile:entities:new')
			profileView = new Profile
				model: profile
			region.show profileView
			profile

	class Profile extends Marionette.ItemView
		template: require './templates/profile'
		behaviors:
			StickIt: {}
		bindings: {
			'#country'  : 'country'
			'#nickName' : 'nickName'
			'#fullName' :
				observe : ['firstName', 'lastName'],
				onGet   : (values) -> if (values[0]?) values[0] + ' ' + values[1] else ''
				onSet   : (value) -> value.split(' ')
			'#gender'   : 'gender'
			'#birthDate': 'birthDate'
			'#imageUrl' : 'imageUrl'
		}


	App.reqres.setHandler 'profile:new', (region) -> Controller.new(region)
