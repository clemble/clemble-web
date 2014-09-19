do (Marionette) ->

	Behaviors =
		StickIt: Marionette.Behavior.extend
			onRender: () ->
				@view.stickit()
			onDestroy: () ->
				@view.unstickit()
		FlowClock: Marionette.Behavior.extend
			onShow: () ->
				@$('.time-left').each((timeLeft) ->
					timeLeftSec = (parseInt($(this).attr("time")) - new Date().getTime()) / 1000
					$(this).FlipClock(timeLeftSec, {
						clockFace: 'DailyCounter',
						countdown: false,
						showSeconds: true
					})
				)

	Marionette.Behaviors.behaviorsLookup = () -> Behaviors
