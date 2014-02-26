angular.module('app.controllers').controller 'ProjectTaskNewCtrl', [
  '$scope', 'Task', '$location', '$route', 'project',
  ($scope, Task, $location, $route, project) ->

    $scope.project = project.data
    $scope.task = new Task projectId: $route.current.params.projectId
    $scope.saveTask = ->
      $scope.task.create()
        .then (task) ->
          $location.path $scope.path 'ProjectTaskIndexCtrl',
            projectId: $scope.project.id
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash =
              type: 'danger',
              message: "#{err.data._message} (#{err.status})"

]
