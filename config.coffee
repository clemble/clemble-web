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

	plugins:
		autoReload:
			port: [9997, 9998, 9999]

	server:
		path: 'app.coffee'
		port: 3333
		run: yes