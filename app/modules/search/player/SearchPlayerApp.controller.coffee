SearchPlayerController = ($http, $q) ->

	selectedItemChange = (text) ->
		console.log('Text changed to ' + text)

	searchTextChange = (item) ->
		console.log('Item changed to ' + JSON.stringify(item));

	querySearch = (query) ->
		url = App.Utils.toUrl("search", "search/player?query=#{query}")
		$http.get(url).then((result) ->
			result.data
		)

	self = @
	self.simulateQuery = false
	self.isDisabled    = false
	self.selectedItemChange = selectedItemChange
	self.searchTextChange = searchTextChange
	self.querySearch = querySearch
	self

angular.
	module('search.player').
	controller('SearchPlayerController', SearchPlayerController);

