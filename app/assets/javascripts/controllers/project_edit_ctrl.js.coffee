angular.module('app.controllers').controller 'ProjectEditCtrl', [
  '$scope', 'project', '$location', 'users', 'Membership', '$route', 'memberships',
  ($scope, project, $location, users, Membership, $route, memberships) ->

    $scope.project = project.data
    $scope.users = users.data
    $scope.memberships = memberships.data

    $scope.deleteMember = (membership) ->
      xhr = Membership.get membership.id
      xhr.then (membership) ->
        membership.delete()
          .then -> $route.reload()

    $scope.nonMembers = (user) ->
      # Does not belong to the project
      _.find($scope.memberships, (m) -> m.userId == user.id) == undefined

    $scope.saveProject = ->
      $scope.project.save()
        .then (project) ->
          $location.path $scope.path 'UserIndexCtrl'
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash =
              type: 'danger'
              message: "#{err.data._message} (#{err.status})"

]
