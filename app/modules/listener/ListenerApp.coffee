@App.module "ListenerApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	player = $.cookie("player")

	if (player?)
		ws = new SockJS("http://ws.#{window.location.hostname}:15674/stomp")
		client = Stomp.over(ws);

		# SockJS does not support heart-beat: disable heart-beats
		client.heartbeat.outgoing = 0
		client.heartbeat.incoming = 0

		on_connect = () ->
			console.log('connected')
			client.subscribe("/topic/#{player}", (message) ->
				messageJSON = JSON.parse(message.body);
				channel = messageJSON.type
				App.trigger channel, messageJSON
				while channel.lastIndexOf(":") != -1
					channel = channel.substring(0, channel.lastIndexOf(":"))
					App.trigger channel, messageJSON
			)

		on_error = () ->
			console.log('error')

		client.connect('guest', 'guest', on_connect, on_error, "/")