angular.
	module('settings.password').
	factory('SettingsPassword', ['$resource', ($resource) -> $resource(App.Utils.toUrl("registration", "change"))])