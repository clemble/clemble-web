match = ($parse) ->
	{
		require: '?ngModel',
		restrict: 'A',
		link: (scope, elem, attrs, ctrl) ->
			console.log("Match called")
			if(!ctrl)
				console.warn('Match validation requires ngModel to be on the element')

			matchGetter = $parse(attrs.match)

			scope.$watch(getMatchValue, () -> ctrl.$$parseAndValidate())

			ctrl.$validators.match = () -> ctrl.$viewValue == getMatchValue()

			getMatchValue = () ->
				match = matchGetter(scope)
				if (angular.isObject(match) && match.hasOwnProperty('$viewValue'))
					match = match.$viewValue
				match
	}

angular.
	module('validation.match', []).
	directive('match', match);
