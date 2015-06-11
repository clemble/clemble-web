SearchPlayerController = ($http, $q) ->
	self = @
	self.simulateQuery = false
	self.isDisabled    = false
	self.selectedItemChange = (text) -> console.log('Text changed to ' + text)
	self.searchTextChange   = (item) -> console.log('Item changed to ' + JSON.stringify(item));

	self.querySearch = (query) ->
		url = App.Utils.toUrl("search", "search/player?query=#{query}")
		$http.get(url).then((result) ->
			result.data
		)

	self

angular.
	module('search.player').
	controller('SearchPlayerController', SearchPlayerController);

