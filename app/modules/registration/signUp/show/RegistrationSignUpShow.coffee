@App.module "RegistrationSignUpApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		registerManual: (region) ->

			layout = new RegistrationLayout
			layout.on 'show', () ->
				registration = App.request 'registration:entities:registration:new'

				App.request "registration:social:show", layout.social
				signupView = new SignupView
					model: registration
				layout.signup.show signupView
			region.show layout

	class SignupView extends Marionette.ItemView
		template: require './templates/signup'
		behaviors:
			StickIt: {}
			DisplayError: {}
		events:
			'click #signUp' : () -> @model.save()
		bindings: {
			'#email': 'emailOrNickName',
			'#password': 'password'
			'#country': 'country'
			'#nickName': 'nickName'
			'#fullName':
				observe: ['firstName', 'lastName'],
				onGet: (values) ->
					if (values[0]? && values[1])
						values[0] + ' ' + values[1]
					else
						''
				onSet: (value) -> value.split(' ')
			'[name="gender"]': 'gender'
			'#birthDate': 'birthDate'
		}


	class RegistrationLayout extends Marionette.LayoutView
		template: require "./templates/layout"
		regions:
			signup   : '#signup'
			social   : '#social'

	App.reqres.setHandler 'registration:signUp:show', (region) -> Controller.registerManual(region)
