angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', 'project', '$route', 'assignments', 'Timelog',
  ($scope, task, project, $route, assignments, Timelog) ->
    $scope.project     = project.data
    $scope.task        = task.data
    $scope.assignments = assignments.data

    $scope.startTimelog = (assignment) ->
      assignment.start()
        .then -> $route.reload()

    $scope.stopTimelog = (assignment) ->
      assignment.stop()
        .then -> $route.reload()

    $scope.deleteTimelog = (timelog) ->
      Timelog.get(timelog.id)
        .then (resource) ->
          resource.delete()
            .then -> $route.reload()
]
