angular.module('app.controllers').controller 'UserIndexCtrl', [
  '$scope', 'users', '$route',
  ($scope, users, $route) ->

    $scope.users = users.data
    $scope.deleteUser = (user) ->
      user.delete()
        .then -> $route.reload()
        .catch (err) ->
          if err.data._message
            $scope.flash = type: 'danger', message: "#{err.data._message} (#{err.status})"

  ]

resolvers.UserIndexResolver =
  users: [
    '$q', 'User',
    ($q, User) ->

      deferred = $q.defer()
      userXhr = User.query()
      userXhr.then (users) ->
        deferred.resolve
          status: 200
          data: users

      deferred.promise

  ]
