RegistrationSocialController = ($scope, $http) ->

	signIn = (url, data) ->
		form = document.createElement("form")
		form.setAttribute("action", url)
		form.setAttribute("method", "post")
		for name, value of data
			hiddenField = document.createElement("input")
			hiddenField.setAttribute("name", name);
			hiddenField.setAttribute("value", value)
			form.appendChild(hiddenField)
			console.log("Appending #{name} with #{value}")
		form.submit()

	$scope.loginFacebook = () ->
		url = App.Utils.toUrl("social", "signin/facebook")
		signIn(url, { scope: "public_profile, email, user_friends, publish_stream, publish_actions" })
	$scope.loginTwitter = () ->
		url = App.Utils.toUrl("social", "signin/twitter")
		signIn(url, {})
	$scope.loginVK = () ->
		url = App.Utils.toUrl("social", "signin/vkontakte")
		signIn(url, { scope: "notify,notifications,email,offline" })
	$scope.loginGoogle = () ->
		url = App.Utils.toUrl("social", "signin/google")
		console.log("Login Google called #{url}")
		signIn(url, {
			scope: "email https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/tasks https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/latitude.all.best https://www.googleapis.com/auth/plus.circles.read"
			request_visible_actions: "http://schemas.google.com/AddActivity http://schemas.google.com/BuyActivity http://schemas.google.com/CheckInActivity http://schemas.google.com/CommentActivity http://schemas.google.com/CreateActivity http://schemas.google.com/DiscoverActivity http://schemas.google.com/ListenActivity http://schemas.google.com/ReserveActivity http://schemas.google.com/ReviewActivity http://schemas.google.com/WantActivity"
			access_type: "offline"
		})
	$scope.loginLinkedIn = () ->
		url = App.Utils.toUrl("social", "signin/linkedin")
		console.log("Login LinkedIn called #{url}")

RegistrationSocialController.$inject = ['$scope', '$http']

angular.
	module('registration.social').
	controller('RegistrationSocialController', RegistrationSocialController)


