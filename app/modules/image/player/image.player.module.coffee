app = angular.module('cl.image.player', ['ngMaterial'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	imagePlayerHtml = require('./cl-image-player')()
	$templateCache.put('image/player/cl-image-player.html', imagePlayerHtml);
