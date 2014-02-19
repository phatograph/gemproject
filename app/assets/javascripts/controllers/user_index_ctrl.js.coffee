angular.module('app.controllers').controller 'UserIndexCtrl', [
  '$scope', 'users', '$route',
  ($scope, users, $route) ->

    $scope.users = users.data
    $scope.deleteUser = (user) ->
      user.delete().then -> $route.reload()

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
