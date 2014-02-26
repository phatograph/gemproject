angular.module('app.controllers').controller 'ProjectTaskAssignmentCtrl', [
  '$scope', '$location', '$route', 'project', 'task', 'assignments', 'Assignment', 'memberships',
  ($scope, $location, $route, project, task, assignments, Assignment, memberships) ->
    $scope.project     = project.data
    $scope.task        = task.data
    $scope.assignments = assignments.data
    $scope.memberships = memberships.data

    $scope.deleteAssignment = (assignment) ->
      xhr = Assignment.get assignment.id

      # TODO: apply rules in policy
      xhr.then (assignment) ->
        assignment.delete()
          .then -> $route.reload()

    $scope.nonAssignees = (membership) ->
      # Does not belong to the task
      _.find($scope.assignments, (x) -> x.userId == membership.userId) == undefined
]
