angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', 'project', '$route', 'assignments',
  ($scope, task, project, $route, assignments) ->
    $scope.project     = project.data
    $scope.task        = task.data
    $scope.assignments = assignments.data

    $scope.startTimelog = (assignment) ->
      assignment.start()
        .then -> $route.reload()

    $scope.stopTimelog = (assignment) ->
      assignment.stop()
        .then -> $route.reload()
]
