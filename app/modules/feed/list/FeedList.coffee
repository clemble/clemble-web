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

	class GoalPost extends Marionette.ItemView
		template: require './templates/goal_post'
		className: 'row'
		modelEvents:
			"sync"    : "render"
		behaviors:
			SocialShare: {}
			BetBehavior: {}

	class Posts extends Marionette.CollectionView
		childView : Post
		childViewContainer : "#caption"
		modelEvents:
			"sync"  : "render"
		getChildView: (item) -> childViewToTemplate(item)

	class PostsModal extends Marionette.CompositeView
		template: require './templates/player_posts_modal'
		childView : Post
		childViewContainer : "#caption"
		modelEvents:
			"sync" : "render"
		getChildView: (item) -> childViewToTemplate(item)

	childViewToTemplate = (item) ->
		if (item.get("type").indexOf("post:goal") != -1)
			GoalPost
		else
			Post
#		if (item.get('type') == "post:goal:created")
#			GoalCreatedPost
#		else if (item.get('type') == "post:goal:started")
#			GoalStartedPost
#		else if (item.get('type') == "post:goal:bet:changed")
#			GoalBetChangedPost
#		else if (item.get('type') == "post:goal:updated:missed")
#			GoalUpdateMissed
#		else if (item.get('type') == "post:goal:updated")
#			GoalUpdatedPost
#		else if (item.get('type') == "post:goal:reached")
#			GoalReachedPost
#		else if (item.get('type') == "post:goal:missed")
#			GoalMissedPost
#		else if (item.get('type') == "post:goal:bet:off")
#			GoalBetOffPost
#		else
#			Post

	Controller =
		listMy: (region) ->
			myPosts = App.request "feed:entities:my"
			myPostsView = new Posts
				collection: myPosts
			region.show myPostsView
		listPlayerInModal: (player) ->
			playerPosts = App.request "feed:entities:player", player
			playerPostsView = new PostsModal
				collection: playerPosts
			App.modal.show playerPostsView


	App.reqres.setHandler "feed:list:my", (region) -> Controller.listMy(region)
	App.reqres.setHandler "feed:list:player:modal", (player) -> Controller.listPlayerInModal(player)