angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', 'project', '$route', 'assignments',
  ($scope, task, project, $route, assignments) ->
    $scope.project = project.data
    $scope.tasks = task.data
    $scope.assignments = assignments.data
]
