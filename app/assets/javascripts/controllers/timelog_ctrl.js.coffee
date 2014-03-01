angular.module('app.controllers').controller 'TimelogCtrl', [
  '$scope', '$route',
  ($scope, $route) ->
    $scope.deleteTimelog = (timelog) ->
      timelog.delete()
        .then -> $route.reload()

    $scope.saveTimelog = (timelog) ->
      timelog.save()
        .then ->
          timelog.editting = false
          $route.reload()

    $scope.refreshPage = ->
      $route.reload()
]
