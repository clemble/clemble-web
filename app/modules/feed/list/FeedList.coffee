@App.module "FeedApp.List", (List, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class Post extends Marionette.ItemView
		template: require './templates/player_post'
		className: 'row'
		behaviors:
			SocialShare: {}
			BetBehavior: {}
			BootstrapTooltip: {}

	class GoalStartedPost extends Marionette.ItemView
		template: require './templates/goal_started'
		className: 'row'
		behaviors:
			SocialShare: {}
			BetBehavior: {}
			BootstrapTooltip: {}

	class GoalCreatedPost extends Marionette.ItemView
		template: require './templates/goal_created'
		className: 'row'
		behaviors:
			SocialShare: {}
			BetBehavior: {}
			BootstrapTooltip: {}

	class GoalBetOffPost extends Marionette.ItemView
		template: require './templates/goal_bet_off'
		className: 'row'

	class GoalBetChangedPost extends Marionette.ItemView
		template: require './templates/goal_bid'
		className: 'row'
		behaviors:
			SocialShare: {}
			BetBehavior: {}
			BootstrapTooltip: {}

	class GoalUpdatedPost extends Marionette.ItemView
		template: require './templates/goal_update'
		className: 'row'
		behaviors:
			SocialShare: {}
			BetBehavior: {}
			BootstrapTooltip: {}

	class GoalReachedPost extends Marionette.ItemView
		template: require './templates/goal_reached'
		className: 'row'
		behaviors:
			SocialShare: {}
			BetBehavior: {}
			BootstrapTooltip: {}

	class GoalMissedPost extends Marionette.ItemView
		template: require './templates/goal_missed'
		className: 'row'
		behaviors:
			SocialShare: {}
			BetBehavior: {}
			BootstrapTooltip: {}

	class GoalUpdateMissed extends Marionette.ItemView
		template: require './templates/goal_update_missed'
		className: 'row'
		behaviors:
			SocialShare: {}
			BetBehavior: {}
			BootstrapTooltip: {}

	class Posts extends Marionette.CompositeView
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
			else if (item.get('type') == "post:goal:bet:changed")
				GoalBetChangedPost
			else if (item.get('type') == "post:goal:updated:missed")
				GoalUpdateMissed
			else if (item.get('type') == "post:goal:updated")
				GoalUpdatedPost
			else if (item.get('type') == "post:goal:reached")
				GoalReachedPost
			else if (item.get('type') == "post:goal:missed")
				GoalMissedPost
			else if (item.get('type') == "post:goal:bet:off")
				GoalBetOffPost
			else
				Post

	Controller =
		listMy: (region) ->
			notification = App.request "feed:entities:my"
			notificationView = new Posts
				collection: notification
			region.show notificationView

	App.reqres.setHandler "feed:list:my", (region) -> Controller.listMy(region)