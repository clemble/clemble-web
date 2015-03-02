require 'config/config'
require 'application'
require 'modules/modules'

# Initialize the application on DOM ready event.
$ ->

	# This is hack to be able to run components, there must be a nicer way to do this
	App.start()

	if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent))
		window.mobile = true
	else
		window.mobile = false
