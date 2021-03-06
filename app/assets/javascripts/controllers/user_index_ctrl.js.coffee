angular.module('app.controllers').controller 'UserIndexCtrl', [
  '$scope', 'users', '$route', 'projects',
  ($scope, users, $route, projects) ->

    $scope.users = users.data
    $scope.projects = projects.data

    $scope.deleteUser = (user) ->
      user.delete()
        .then -> $route.reload()
        .catch (err) ->
          if err.data._message
            $scope.flash =
              type: 'danger'
              message: "#{err.data._message} (#{err.status})"

    $scope.deleteProject = (project) ->
      project.delete()
        .then -> $route.reload()
        .catch (err) ->
          if err.data._message
            $scope.flash =
              type: 'danger'
              message: "#{err.data._message} (#{err.status})"

]
