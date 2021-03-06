angular.module('app.controllers').controller 'UserNewCtrl', [
  '$scope', 'User', '$location',
  ($scope, User, $location) ->

    $scope.user = new User()
    $scope.saveUser = ->
      $scope.user.create()
        .then (user) ->
          $location.path $scope.path 'UserIndexCtrl'
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash = type: 'danger', message: "#{err.data._message} (#{err.status})"

]
