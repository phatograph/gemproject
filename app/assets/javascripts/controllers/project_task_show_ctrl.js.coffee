angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', '$route',
  ($scope, task, $route) ->
    $scope.task         = task.data
    $scope.project      = $scope.task.project
    $scope.assignments  = $scope.task.assignments
    if $scope.task.myAssignment?
      $scope.myAssignment = for a in $scope.assignments when
        a.id is $scope.task.myAssignment.id
]
