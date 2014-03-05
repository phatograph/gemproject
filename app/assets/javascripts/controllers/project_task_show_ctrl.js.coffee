angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', 'project', '$route', 'myAssignment', 'assignments'
  ($scope, task, project, $route, myAssignment, assignments) ->
    $scope.project      = project.data
    $scope.task         = task.data
    $scope.assignments  = assignments.data
    $scope.myAssignment = myAssignment.data
]
