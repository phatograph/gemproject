angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', '$route',
  ($scope, task, $route) ->
    $scope.task         = task.data
    $scope.project      = $scope.task.project
    $scope.assignments  = $scope.task.assignments
    if $scope.task.myAssignment?
      $scope.myAssignment = _.find $scope.assignments, (a) ->
        a.id is $scope.task.myAssignment.id
]
