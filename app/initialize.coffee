require 'config/config'
require 'application'
require 'modules/modules'

# Initialize the application on DOM ready event.
$ ->

	# This is hack to be able to run components, there must be a nicer way to do this
	App.start()
