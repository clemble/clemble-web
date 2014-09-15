@App.module "GoalConfigurationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class GoalConfiguration extends Backbone.Model
		defaults:
			bid: null
			betRule: null
			judgeRule: null
			privacyRule: null
			moveTimeRule: null
			totalTimeRule: null

	class GoalConfigurations extends Backbone.Collection
		model: GoalConfiguration

	API =
		getConfigurations: () ->
			configurations = new GoalConfigurations()
			configurations.url = "/goal/configuration/my"
			configurations.fetch()
			configurations

	App.reqres.setHandler "goal:configuration:entities:get", () -> API.getConfigurations()
