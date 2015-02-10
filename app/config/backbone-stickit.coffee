Backbone.Stickit.addHandler({
	selector: '.slider',
	events: ['change', 'stop'],

	initialize: ($el, model, options) ->
		sliderOptions = _.extend({
			value: model.get(options.observe),
			slide: () ->
				# Defer since the `slide` event is triggered
				# before the actual $el.slide('value') is updated.
				_.defer(() -> $el.trigger('change'))
			stop: () ->
				console.log('stop');
				_.defer(() -> $el.trigger('stop'))
		}, options.sliderOptions )

		$el.slider(sliderOptions)

	update: ($el, val, model, options) ->
		console.log('updating val')
		_.defer(() -> $el.slider('value', model.get(options.observe)))

	getVal: ($el) ->
		console.log('getting val')
		$el.slider('value')

})