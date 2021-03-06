match = ($parse) ->
	{
		require: '?ngModel',
		restrict: 'A',
		link: (scope, elem, attrs, ctrl) ->
			if(!ctrl)
				console.warn('Match validation requires ngModel to be on the element')

			matchGetter = $parse(attrs.match)

			scope.$watch(getMatchValue, () -> ctrl.$$parseAndValidate())

			ctrl.$validators.match = () ->
				console.log("Match called")
				ctrl.$viewValue == getMatchValue()

			getMatchValue = () ->
				match = matchGetter(scope)
				if (angular.isObject(match) && match.hasOwnProperty('$viewValue'))
					match = match.$viewValue
				match
	}

angular.
	module('validation.match', []).
	directive('match', match);
