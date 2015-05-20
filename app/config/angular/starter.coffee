Controller =
	launch: (region, app, template) ->
		model = new Backbone.Model({ app: app})
		loginView = new AngularContainer
			template: template
			model: model
		region.show loginView

class AngularContainer extends Marionette.ItemView
	onShow: () =>
		angular.bootstrap(@el, [@model.get('app')])

@AngularStarter = {
	start: (region, app, template) ->
		Controller.launch(region, app, template)
}