@App.module "VictoryApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Victory extends Backbone.Model
		defaults:
			goalKey     : ''
			player      : ''
			supporters  : []
			goal        : ''
			bank        : ''
			timezone    : ''
		idAttribute:  'goalKey'

	class Victories extends Backbone.Collection
		model: Victory

	API =
		list: (player) ->
			victories = new Victories()
			victories.url = App.Utils.toUrl("management", "player/victory/#{player}")
			victories.fetch()
			victories

	App.reqres.setHandler "victory:entities:my", () -> API.list('my')
	App.reqres.setHandler "victory:entities:list", (player) -> API.list(player)