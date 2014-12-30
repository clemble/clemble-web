@App.module "FeedApp.List", (List, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class Post extends Marionette.ItemView
		template: require './templates/player_post'

	class GoalStartedPost extends Marionette.ItemView
		template: require './templates/goal_started'

	class GoalCreatedPost extends Marionette.ItemView
		template: require './templates/goal_created'
		events:
			'click #bet' : "bet"
		bet: () ->
			App.request "goal:active:action:bid:modal", @model.get('goalKey'), @model.get("configuration")

	class GoalBidPost extends Marionette.ItemView
		template: require './templates/goal_bid'
		events:
			'click #bet' : "bet"
		bet: () ->
			App.request "goal:active:action:bid:modal", @model.get('goalKey'), @model.get("configuration")

	class GoalUpdatedPost extends Marionette.ItemView
		template: require './templates/goal_update'

	class GoalReachedPost extends Marionette.ItemView
		template: require './templates/goal_reached'

	class GoalMissedPost extends Marionette.ItemView
		template: require './templates/goal_missed'

	class Notifications extends Marionette.CompositeView
		template: require './templates/player_posts'
		childView : Post
		childViewContainer : "#caption"
		modelEvents:
			"sync" : "render"
		getChildView: (item) ->
			if (item.get('type') == "post:goal:created")
				GoalCreatedPost
			else if (item.get('type') == "post:goal:started")
				GoalStartedPost
			else if (item.get('type') == "post:goal:bid")
				GoalBidPost
			else if (item.get('type') == "post:goal:updated")
				GoalUpdatedPost
			else if (item.get('type') == "post:goal:reached")
				GoalReachedPost
			else if (item.get('type') == "post:goal:missed")
				GoalMissedPost
			else
				Post

	Controller =
		listMy: (region) ->
			notification = App.request "feed:entities:my"
			notificationView = new Notifications
				collection: notification
			region.show notificationView

	App.reqres.setHandler "feed:list:my", (region) -> Controller.listMy(region)