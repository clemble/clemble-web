express = require 'express'
httpProxy = require 'http-proxy'

http = require('http')
url = require('url')

app = express()


app.use (err, req, res, next) ->
	res.send(501, 'EXPRESS SAYS Something broke!')

PROXY_REGISTRY = {}

registerProxy = (subdomain, port) ->
	proxy = new httpProxy.createProxyServer(target: "http://127.0.0.1:#{port}")
	proxy.on 'error', (err, req, res) ->
		console.log err.stack
		res.send(500, "#{port} & #{subdomain} Do not work")

	proxy.tryProxyRequest = (req, res) ->
			console.log "relaying #{subdomain} #{req.method}:#{req.url} through internal proxy"
			try
				proxy.proxyRequest(req, res);
				console.log "finish relaying #{subdomain} #{req.method}:#{req.url} through internal proxy"
			catch error
				console.log "error relaying #{subdomain} #{req.method}:#{req.url} through internal proxy"
				res.send(500, error)

	PROXY_REGISTRY[subdomain] = proxy


registerProxy('registration', 8080)

app.use('/fonts/', express.static __dirname + '/public/fonts')
app.use('/images/', express.static __dirname + '/public/images')
app.use('/img/', express.static __dirname + '/public/img')
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
		subdomain = req.headers.host.substring(0, req.headers.host.indexOf("."))
		proxy = PROXY_REGISTRY[subdomain].tryProxyRequest(req, res)


	app.listen port
	console.log "Listening on port: #{port}"