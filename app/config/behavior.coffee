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
					if (timeLeftSec > 0)
						$(this).FlipClock(timeLeftSec, {
							clockFace: 'DailyCounter',
							countdown: false,
							showSeconds: true
						})
					else
						$(this).text("It's time")
				)

	Marionette.Behaviors.behaviorsLookup = () -> Behaviors
