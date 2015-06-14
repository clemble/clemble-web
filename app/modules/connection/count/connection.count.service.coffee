ConnectionCountService = ($resource, $http) ->
	$resource(App.Utils.toUrl("connection", ":player/count"),
		{ player : '@id' },
		{
			get: {
				method: 'GET',
				transformResponse: (data, headers) ->
					{ friends : data }
				}
		}
	)

#	@get = (player) ->
#		url = App.Utils.toUrl("connection", "#{player}/count")
#		$http.get(url).
#		success((data, status, headers, config) ->
#
#		}).

angular.
	module('cl.connection.count').
	factory('ConnectionCountService', ['$resource', ConnectionCountService])