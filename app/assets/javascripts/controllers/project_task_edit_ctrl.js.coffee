angular.module('app.controllers').controller 'ProjectTaskEditCtrl', [
  '$scope', '$location', '$route', 'project', 'task',
  ($scope, $location, $route, project, task) ->
    $scope.project = project.data
    $scope.task = task.data

    $scope.saveTask = ->
      $scope.task.save()
        .then (task) ->
          $location.path $scope.path 'ProjectTaskIndexCtrl',
            projectId: $scope.project.id
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash =
              type: 'danger'
              message: "#{err.data._message} (#{err.status})"
]
