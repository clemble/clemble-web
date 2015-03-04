@App.module "FeedApp.List", (List, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class PlayerPost extends Marionette.ItemView
		behaviors:
			ClickPlayer: {}
			SocialShare: {}
			BetBehavior: {}
			BootstrapTooltip: {}

	class Post extends PlayerPost
		template: require './templates/player_post'
		className: 'row list-group-item-info'

	class GoalPostItem extends PlayerPost
		template: (m) ->
			if (window.mobile)
				require('./templates/goal_post_list_sm')(m)
			else
				require('./templates/goal_post_list')(m)
		className: 'row list-group-item-info'
		modelEvents:
			"sync"    : "render"

	class GoalPostFinishedItem extends PlayerPost
		template: (m) ->
			if (window.mobile)
				require('./templates/goal_post_list_finished_sm')(m)
			else
				require('./templates/goal_post_list_finished')(m)
		className: 'row list-group-item-warning'
		modelEvents:
			"sync"    : "render"

	class GoalPostMissedItem extends PlayerPost
		template: (m) ->
			if (window.mobile)
				require('./templates/goal_post_list_missed_sm')(m)
			else
				require('./templates/goal_post_list_missed')(m)
		className: 'row list-group-item-danger'
		modelEvents:
			"sync"    : "render"

	class PostList extends Marionette.CollectionView
		className : "list-group"
		childView : GoalPostItem
		childViewContainer : "#caption"
		modelEvents:
			"sync"  : "render"
		getChildView: (item) ->
			if (item.get("type").indexOf("post:goal") != -1)
				if (item.get("type") == "post:goal:reached")
					GoalPostFinishedItem
				else if (item.get("type") == "post:goal:missed")
					GoalPostMissedItem
				else
					GoalPostItem
			else
				Post

	Controller =
		list: (player, region) ->
			posts = App.request "feed:entities:player", player
			postsView = new PostList
				collection: posts
			region.show postsView

	App.reqres.setHandler "feed:list", (player, region) -> Controller.list(player, region)
	App.reqres.setHandler "feed:list:my", (region) -> Controller.list('my', region)