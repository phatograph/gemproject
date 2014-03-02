angular.module('app.controllers').controller 'TimelogToggleCtrl', [
  '$scope', '$route',
  ($scope, $route) ->
    # Needs `$scope.my_assignment`

    $scope.startTimelog = (assignment) ->
      assignment.start()
        .then -> $route.reload()

    $scope.stopTimelog = (assignment) ->
      assignment.stop()
        .then -> $route.reload()
]
