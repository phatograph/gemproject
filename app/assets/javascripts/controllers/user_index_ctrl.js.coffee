angular.module('app.controllers').controller 'UserIndexCtrl', [
  '$scope', 'users',
  ($scope, users) ->

    $scope.users = users.data

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
