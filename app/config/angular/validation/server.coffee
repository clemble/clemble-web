server = (validator) ->
	() ->
		{
			restrict: 'A',
			require: '?ngModel',
			link: (scope, elm, attr, ctrl) ->
				ctrl.$validators[validator] = (modelValue, viewValue) ->
					true
  }

app = angular.module('validation.server', [])

app.directive('weak', server('weak'))
app.directive('unknown', server('unknown'))
app.directive('incorrect', server('incorrect'))
