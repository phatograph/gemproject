angular.module('app.directives').directive 'loadingButton', [
  ->
    restrict: 'A',
    link: (scope, elem, attrs) ->
      elem.bind 'click', ->
        # Button will be reset upon loader in application.js.coffee
        elem.button('loading')
        scope.$apply attrs.ngLoadingClick
  ]
