angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', 'project', '$route', 'my_assignment', 'assignments'
  ($scope, task, project, $route, my_assignment, assignments) ->
    $scope.project       = project.data
    $scope.task          = task.data
    $scope.assignments   = assignments.data
    $scope.my_assignment = my_assignment.data
]
