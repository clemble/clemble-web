@App.module "ListenerApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

#	player = $.cookie("player")

	ws = new SockJS("http://ws.#{window.location.hostname}:15674/stomp")
	client = Stomp.over(ws);

	on_connect = () ->
		console.log('connected')

	on_error = () ->
		console.log('error')

	client.connect('guest', 'guest', on_connect, on_error, '/');