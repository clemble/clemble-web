app = angular.module('cl.experimental', [
	'ngMaterial',
	'ngResource',
	'cl.search.player'
])

App.reqres.setHandler "experimental:show", (region) -> AngularStarter.start(region, 'cl.experimental', require './experimental')