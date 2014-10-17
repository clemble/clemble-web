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
							countdown: true,
							showSeconds: true
						})
					else
						$(this).text("It's time")
				)
				@$('.time-spent').each((timeLeft) ->
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
		MarionetteModal: Marionette.Behavior.extend
			events:
				'click #save'       : "save"
				'click #cancel'     : "cancel"
			save: () ->
				view = @view
				model = view.model
				model.save(model.toJSON(), {
					success: () ->
						#TODO really ugly shit
						view.$el.parent().parent().parent().parent().modal("hide")
				})
			cancel: () ->
				@$el.parent().parent().parent().parent().modal("hide")

	Marionette.Behaviors.behaviorsLookup = () -> Behaviors
