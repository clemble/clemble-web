express = require 'express'
httpProxy = require 'http-proxy'

http = require('http')
url = require('url')

app = express()

app.use (err, req, res, next) ->
	res.send(500, 'EXPRESS SAYS Something broke!')

proxy = new httpProxy.createProxyServer(target: 'http://localhost:8080')
proxy.on 'error', (err, req, res) ->
	console.log err.stack
	res.send(500, 'PROXY SAYS Something broke!')

adminProxy = new httpProxy.createProxyServer(target: 'http://localhost:3000')
adminProxy.on 'error', (err, req, res) ->
	console.log err.stack
	res.send(500, 'Something broke!')

app.use('/fonts/', express.static __dirname + '/public/fonts')
app.use('/images/', express.static __dirname + '/public/images')
app.use('/javascripts/', express.static __dirname + '/public/javascripts')
app.use('/stylesheets/', express.static __dirname + '/public/stylesheets')

app.all '/*', (req, res, next)->
	console.log "#{req.method}:#{req.url} @#{req.ip} #{JSON.stringify(req.body)}"
	next()

exports.startServer = (port, path, callback) ->

	app.use express.bodyParser()


	app.get '/', (req, res) ->
		res.sendfile './public/index.html'

	app.all '/*', (req, res)->
		console.log "relaying #{req.method}:#{req.url} thru internal proxy"
		try
			proxy.proxyRequest(req, res);
			console.log "finish relaying #{req.method}:#{req.url} thru internal proxy"
		catch error
			console.log "error relaying #{req.method}:#{req.url} thru internal proxy"
			res.send(500, error)

	app.listen port
	console.log "Listening on port: #{port}"