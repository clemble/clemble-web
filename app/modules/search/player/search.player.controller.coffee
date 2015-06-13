SearchPlayerAutocompleteController = ($scope, $http, $q) ->

	selectedItemChange = (item) ->
		$scope.selectedPlayer = item.player

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

SearchPlayerController = ($scope, $http) ->

	console.log("PlayerController > #{JSON.stringify($scope.item)}")

	self = @
	@

angular.
	module('cl.search.player').
	controller('SearchPlayerAutocompleteController', SearchPlayerAutocompleteController).
	controller('SearchPlayerController', SearchPlayerController);

