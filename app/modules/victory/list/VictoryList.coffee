@App.module "VictoryApp.List", (List, App, Backbone, Marionette, $, _) ->

	class Victory extends Marionette.ItemView
		template: require './templates/victory'
#		className: 'list-group-item'
		modelEvents:
			'sync'  : 'render'

	class Victories extends Marionette.CompositeView
		template: require './templates/victories'
		childView: Victory
		childViewContainer : "#caption"

	Controller =
		listMy: (region) ->
			victories = App.request "victory:entities:my"
			victoriesView = new Victories
				collection: victories
			region.show victoriesView

	App.reqres.setHandler "victory:list:my", (region) -> Controller.listMy(region)