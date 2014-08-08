exports.config =
	# See http://brunch.io/#documentation for docs.
	files:
		javascripts:
			joinTo:
				'javascripts/app.js': /^app/
				'javascripts/vendor.js': /^(?!app)/

		stylesheets:
			joinTo: 'stylesheets/app.css'

		templates:
			joinTo: 'javascripts/app.js'

	server:
		path: 'app.coffee'
		port: 3333
		run: yes