do (Marionette) ->

	Behaviors =
		StickIt: Marionette.Behavior.extend
			onRender: () ->
				@view.stickit()
			onDestroy: () ->
				@view.unstickit()

	Marionette.Behaviors.behaviorsLookup = () -> Behaviors
