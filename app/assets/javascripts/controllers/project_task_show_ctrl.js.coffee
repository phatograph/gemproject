angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', 'project', '$route', 'assignments', 'Timelog'
  ($scope, task, project, $route, assignments, Timelog) ->
    $scope.project = project.data
    $scope.task = task.data
    $scope.assignments = assignments.data

    $scope.createTimelog = ->
      timelog = new Timelog taskId: $scope.task.id
      timelog.create()
        .then -> $route.reload()
]
