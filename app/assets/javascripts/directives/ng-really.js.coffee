angular.module('app').directive 'ngReallyClick', [
  ->
    restrict: 'A',
    link: (scope, element, attrs) ->
      element.bind 'click', ->
        message = attrs.ngReallyMessage || 'Are you sure?'
        if message && confirm(message)
            scope.$apply attrs.ngReallyClick
  ]
