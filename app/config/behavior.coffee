do (Marionette) ->

	Behaviors =
		StickIt: Marionette.Behavior.extend
			onShow: () ->
				@view.stickit()
			onDestroy: () ->
				@view.unstickit()

	Marionette.Behaviors.behaviorsLookup = () -> Behaviors
