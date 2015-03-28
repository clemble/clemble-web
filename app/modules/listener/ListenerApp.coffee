@App.module "ListenerApp", (ListenerApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	PLAYER = $.cookie("player")

	API =
		connect: () ->
			PLAYER = $.cookie("player")
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
						console.log ("Notifying my #{channel}")
						while channel.lastIndexOf(":") != -1
							channel = channel.substring(0, channel.lastIndexOf(":"))
							App.trigger "#{channel}:my", messageJSON
							console.log ("Notifying my #{channel}")

					App.trigger channel, messageJSON
					console.log ("Notifying #{channel}")
					while channel.lastIndexOf(":") != -1
						channel = channel.substring(0, channel.lastIndexOf(":"))
						console.log "Triggering event on #{channel}"
						App.trigger channel, messageJSON
						console.log ("Notifying #{channel}")
				)

			on_error = () ->
				console.log('error')

			client.connect('clemble', 'clemble', on_connect, on_error, "/")

		subscribe: (channel, postfix, collection, constuctor) ->
			App.on "#{channel}:created#{postfix}", (event) ->
				console.log("Adding #{JSON.stringify(event)}")
				collection.add(constuctor(event.body), {at: 0})

			App.on "#{channel}:changed#{postfix}", (event) ->
				console.log("Updating #{JSON.stringify(event)}")
				model = constuctor(event.body)
				existingModel = collection.get(model.id)
				if (existingModel?)
					existingModel.set(model.attributes)
				else
					collection.add(model, {at: 0})

			App.on "#{channel}:complete#{postfix}", (event) ->
				console.log("Removing #{JSON.stringify(event)}")
				model = constuctor(event.body)
				collection.remove(model)

		subscribeReply: (channel, postfix, collection, constuctor) ->
			App.on "#{channel}:created#{postfix}", (event) ->
				console.log("Adding #{JSON.stringify(event)}")
				collection.add(constuctor(event.body))

			remove = (event) ->
				console.log("Removing #{JSON.stringify(event)}")
				model = constuctor(event.body)
				collection.remove(model)

			App.on "#{channel}:accepted#{postfix}", remove
			App.on "#{channel}:declined#{postfix}", remove

	if (PLAYER?)
		API.connect()

	App.on "registered", () -> API.connect()

	App.reqres.setHandler "listener:subscribe", (channel, collection, constuctor) -> API.subscribe(channel, "", collection, constuctor)
	App.reqres.setHandler "listener:subscribe:my", (channel, collection, constuctor) -> API.subscribe(channel, ":my", collection, constuctor)
	App.reqres.setHandler "listener:subscribe:reply:my", (channel, collection, constuctor) -> API.subscribeReply(channel, ":my", collection, constuctor)