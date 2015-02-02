require 'config/config'
require 'application'
require 'modules/modules'

# Initialize the application on DOM ready event.
$ ->
	# Tell jQuery to watch for any 401 or 403 errors and handle them appropriately
	$.ajaxSetup {
		statusCode: {
#			401: -> window.location.replace('#registration')
#			403: -> window.location.replace('#denied')
#			404: -> window.location.replace('#error/404')
#			500: -> window.location.replace('#error/500')
		}
		xhrFields: {
			withCredentials: true
		}
	}

	# This is hack to be able to run components, there must be a nicer way to do this
	App.start()
