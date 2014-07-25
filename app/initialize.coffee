require 'config/config'
require 'application'
require 'modules/modules'

# Initialize the application on DOM ready event.
$ ->
	# Tell jQuery to watch for any 401 or 403 errors and handle them appropriately
	$.ajaxSetup {
		statusCode: {
			401: -> window.location.replace('#login')
			403: -> window.location.replace('#denied')
		}
	}

	# This is hack to be able to run components, there must be a nicer way to do this
	App.start()
