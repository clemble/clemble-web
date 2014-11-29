do (Marionette) ->

	Behaviors =
		StickIt: Marionette.Behavior.extend
			onRender: () ->
				@view.stickit()
			onDestroy: () ->
				@view.unstickit()
		StickValidation: Marionette.Behavior.extend
			onRender: () ->
				Backbone.Validation.bind(@view);
			onDestroy: () ->
				Backbone.Validation.unbind(@view);
		Countdown: Marionette.Behavior.extend
			modelEvents:
				'change': 'updateDate'
				'sync': 'updateDate'
			onRender: () -> @updateDate()
			onShow: () -> @updateDate()
			updateDate: () ->
				console.log("countdown")
				@view.$('[data-countdown]').each(() ->
					$this = $(this)
					finalDate = $(this).data('countdown');
					$this.countdown(finalDate, (event) ->
						days = parseInt(event.strftime('%d'))
						if (days > 1)
							hourMinutes = event.strftime('%H:%M')
							$this.html("#{days} / #{hourMinutes}");
						else if (days == 1)
							hourMinutes = event.strftime('%H:%M:%S')
							$this.html("1 / #{hourMinutes}");
						else
							hourMinutes = event.strftime('%H:%M:%S')
							$this.html("#{hourMinutes}");
					)
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
		DisplayError: Marionette.Behavior.extend
			modelEvents:
				'error'             : "showError"
			showError: (model, resp, options) ->
				#TODO make this more sophisticated
				@view.$('.help-block:first').html(resp.responseJSON[0].error.description).removeClass('hidden')

	Marionette.Behaviors.behaviorsLookup = () -> Behaviors
