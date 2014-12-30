do (Backbone) ->

	_.extend(Backbone.Validation.callbacks, {
		valid: (view, attr, selector) ->
			$el = view.$('#' + attr)
			$group = $el.closest('.form-group')

			$group.removeClass('has-error')
			$group.find('.help-block').html('').addClass('hidden')
		invalid: (view, attr, error, selector) ->
			$el = view.$('#' + attr)
			$group = $el.closest('.form-group')

			$group.addClass('has-error')
			$group.find('.help-block').html(error).removeClass('hidden')
	})

	_.extend(Backbone.Collection, {
		setSelected: (model) =>
			# Notifying of changed selection
			if (@selected?)
				@trigger("unselected:#{@selected.get('configurationKey')}", @selected)
				@trigger("unselected", @selected)

			# Specifying new selection
			@selected = model
			@trigger("selected:#{@selected.get('configurationKey')}", @selected)
			@trigger("selected", @selected)
		getSelected: () =>
			@selected
	})