angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', 'project', '$route', 'assignments', 'my_assignment', '$sce',
  ($scope, task, project, $route, assignments, my_assignment, $sce) ->
    $scope.project       = project.data
    $scope.task          = task.data
    $scope.assignments   = assignments.data
    $scope.my_assignment = my_assignment.data

    $scope.startTimelog = (assignment) ->
      assignment.start()
        .then -> $route.reload()

    $scope.stopTimelog = (assignment) ->
      assignment.stop()
        .then -> $route.reload()

    $scope.deleteTimelog = (timelog) ->
      timelog.delete()
        .then -> $route.reload()

    $scope.saveTimelog = (timelog) ->
      timelog.save()
        .then ->
          timelog.editting = false
          $route.reload()

    $scope.resetTimelog = (timelog) ->
      timelog.editting = false
      $route.reload()
]
