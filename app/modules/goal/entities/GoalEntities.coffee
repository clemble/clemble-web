@App.module "GoalTrack.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Goal extends Backbone.Model
		defaults:
			player      : null
			goal        : null
			description : null
			state       : null
			bet         : null
			rate        : null
			dueDate     : null
		idAttribute:
			'goal'

	class Goals extends Backbone.Collection
		model:
			Goal

	API =
		all: (player) ->
			goals = new Goals()
			goals.url = "http://#{App.host}/goal/track/#{player}"
			goals.fetch()
			goals
		reached: (player) ->
			goals = new Goals()
			goals.url = "http://#{App.host}/goal/track/#{player}/reached"
			goals.fetch()
			goals
		missed: (player) ->
			goals = new Goals()
			goals.url = "http://#{App.host}/goal/track/#{player}/missed"
			goals.fetch()
			goals
		pending: (player) ->
			goals = new Goals()
			goals.url = "http://#{App.host}/goal/track/#{player}/pending"
			goals.fetch()
			goals

	App.reqres.setHandler "goal:track:entities:my", () -> API.all('me')
	App.reqres.setHandler "goal:track:entities:my:reached", () -> API.reached('me')
	App.reqres.setHandler "goal:track:entities:my:missed", () -> API.missed('me')
	App.reqres.setHandler "goal:track:entities:my:pending", () -> API.pending('me')

	App.reqres.setHandler "goal:track:entities:all", (player) -> API.all(player)
	App.reqres.setHandler "goal:track:entities:reached", (player) -> API.reached(player)
	App.reqres.setHandler "goal:track:entities:missed", (player) -> API.missed(player)
	App.reqres.setHandler "goal:track:entities:pending", (player) -> API.pending(player)