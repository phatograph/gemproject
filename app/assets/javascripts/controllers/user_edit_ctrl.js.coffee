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

resolvers.UserShowResolver =
  user: [
    '$q', 'User', '$route',
    ($q, User, $route) ->

      deferred = $q.defer()
      userXhr = User.get $route.current.params.userId

      userXhr.then (user) -> deferred.resolve status: 200, data: user
      userXhr.catch (error) -> deferred.resolve status: 404, data: error.data
      deferred.promise

  ]
