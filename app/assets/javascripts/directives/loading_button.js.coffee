angular.module('app.directives').directive 'loadingButton', [
  ->
    restrict: 'A',
    link: (scope, element, attrs) ->
      element.bind 'click', ->
        element.button('loading')
        scope.$apply attrs.ngLoadingClick
  ]
