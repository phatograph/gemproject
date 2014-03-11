angular.module('app.controllers').controller 'MainNavCtrl', [
  '$scope', '$route',
  ($scope, $route) ->
    $scope.currentController = $route.current.$$route.controller
]
