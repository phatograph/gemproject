angular.module('app.controllers').controller 'UserEditCtrl', [
  '$scope', 'user', '$location',
  ($scope, user, $location) ->

    $scope.user = user.data
    $scope.saveUser = ->
      $scope.user.save()
        .then (user) ->
          $location.path $scope.path 'UserIndexCtrl'
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash = type: 'danger', message: "#{err.data._message} (#{err.status})"
  ]
