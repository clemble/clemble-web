@App.module "ListenerApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	PLAYER = $.cookie("player")

	if (PLAYER?)
		ws = new SockJS("http://ws.#{window.location.hostname}:15674/stomp")
		client = Stomp.over(ws);

		# SockJS does not support heart-beat: disable heart-beats
		client.heartbeat.outgoing = 0
		client.heartbeat.incoming = 0

		on_connect = () ->
			console.log('connected')
			client.subscribe("/topic/#{PLAYER}", (message) ->
				messageJSON = JSON.parse(message.body);
				channel = messageJSON.type
				# Send all notifications for current user with my postfix
				if (messageJSON.player? && messageJSON.player == PLAYER)
					App.trigger "#{channel}:my", messageJSON
					while channel.lastIndexOf(":") != -1
						channel = channel.substring(0, channel.lastIndexOf(":"))
						App.trigger "#{channel}:my", messageJSON
				else
					App.trigger channel, messageJSON
					while channel.lastIndexOf(":") != -1
						channel = channel.substring(0, channel.lastIndexOf(":"))
						App.trigger channel, messageJSON
			)

		on_error = () ->
			console.log('error')

		client.connect('any', 'anypassword', on_connect, on_error, "/")