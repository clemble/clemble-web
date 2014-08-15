@App.module "GoalTrack.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Goal extends Backbone.Model
		defaults:
			player      : null
			goalKey     : null
			state       : null
			description : null
			dueDate     : null
			statuses    : []
		idAttribute:
			'goal'

	class Goals extends Backbone.Collection
		model:
			Goal

	API =
		all: (player) ->
			goals = new Goals()
			goals.url = "/goal/track/#{player}"
			goals.fetch()
			goals
		reached: (player) ->
			goals = new Goals()
			goals.url = "/goal/track/#{player}/reached"
			goals.fetch()
			goals
		missed: (player) ->
			goals = new Goals()
			goals.url = "/goal/track/#{player}/missed"
			goals.fetch()
			goals
		pending: (player) ->
			goals = new Goals()
			goals.url = "/goal/track/#{player}/pending"
			goals.fetch()
			goals
		new: (player) ->
			goal = new Goal()
			goal.url = "/goal/track/#{player}"
			goal.on "all", (evt) -> console.log("goal > #{evt}")
			goal

	App.reqres.setHandler "goal:entities:my", () -> API.all('my')
	App.reqres.setHandler "goal:entities:my:reached", () -> API.reached('my')
	App.reqres.setHandler "goal:entities:my:missed", () -> API.missed('my')
	App.reqres.setHandler "goal:entities:my:pending", () -> API.pending('my')
	App.reqres.setHandler "goal:entities:my:new", () -> API.new('my')

	App.reqres.setHandler "goal:entities:all", (player) -> API.all(player)
	App.reqres.setHandler "goal:entities:reached", (player) -> API.reached(player)
	App.reqres.setHandler "goal:entities:missed", (player) -> API.missed(player)
	App.reqres.setHandler "goal:entities:pending", (player) -> API.pending(player)