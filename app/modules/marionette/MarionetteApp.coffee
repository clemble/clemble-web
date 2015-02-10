@App.module 'MarionetteApp', (MarionetteApp, App, Backbone, Marionette, $, _) ->

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
		BootstrapTooltip: Marionette.Behavior.extend
			onRender: () ->
				@$('[data-toggle="tooltip"]').tooltip()
		Delete: Marionette.Behavior.extend
			events:
				'click #delete' : 'delete'
			delete: () ->
				model = @view.model
				collection = @view.model.collection
				if (model?)
					model.destroy()
				if (collection?)
					collection.remove(model)
		BetBehavior: Marionette.Behavior.extend
			events:
				'click #bet'    : "bet"
				'click #support': 'support'
				'click #observe': 'observe'
			bet: () ->
				App.request "goal:active:action:bid:modal", @view.model.get('goalKey'), @view.model.get("configuration")
			support: () ->
				App.request "goal:active:action:support:modal", @view.model
			observe: () ->
				App.request "goal:active:action:observe:modal", @view.model

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
			initialize: () ->
				self = @
				@view.on 'modal:close', () ->
					self.closeModal()
			save: () ->
				self = @
				model = @view.model
				model.save(model.toJSON(), {
					success: () ->
						#TODO really ugly shit
						self.closeModal()
				})
			cancel: () ->
				@closeModal()
			closeModal: () ->
				@$el.parent().parent().parent().parent().modal("hide")
		DisplayError: Marionette.Behavior.extend
			modelEvents:
				'error'             : "showError"
			showError: (model, resp, options) ->
				#TODO make this more sophisticated
				@view.$('.help-block:first').html(resp.responseJSON[0].error.description).removeClass('hidden')
		SocialShare: Marionette.Behavior.extend
			events:
				'click [share]'  : "share"
			share: (evt) ->
				provider = evt.currentTarget.getAttribute("share")
				url = App.Utils.toUrl(@view.model.url() + "/share")
				$.ajax({
					type: 'POST',
					url: url,
					data: JSON.stringify(provider),
					contentType: "application/json",
					dataType: 'json'
				})

	Marionette.Behaviors.behaviorsLookup = () -> Behaviors