do(Backbone) ->
	originalFetch = Backbone.Model.prototype.fetch;

	Backbone.Model.prototype.fetch = (options) ->

		originalError = options.error;

		options.error = (model, error) ->
			if (originalError)
				originalError(model, error)
#
#			# call your global error handler here.
#			App.myGlobalErrorHandler(model, error)


		originalFetch.apply(this, arguments)