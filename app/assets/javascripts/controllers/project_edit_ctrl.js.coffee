angular.module('app.controllers').controller 'ProjectEditCtrl', [
  '$scope', 'project', '$location', 'users', 'Membership', '$route', 'memberships',
  ($scope, project, $location, users, Membership, $route, memberships) ->
    $scope.project = project.data
    $scope.users = users.data
    $scope.memberships = memberships.data

    $scope.deleteMember = (membership) ->
      membership.delete()
        .then -> $route.reload()
        .catch (err) ->
          if err.status is 401
            $scope.membershipError = "* Please remove user from all task before remove him/her from this project."

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
