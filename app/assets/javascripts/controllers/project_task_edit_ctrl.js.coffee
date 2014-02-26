angular.module('app.controllers').controller 'ProjectTaskEditCtrl', [
  '$scope', '$location', '$route', 'project', 'task', 'assignments', 'Assignment', 'memberships',
  ($scope, $location, $route, project, task, assignments, Assignment, memberships) ->
    $scope.project = project.data
    $scope.task = task.data
    $scope.assignments = assignments.data
    $scope.memberships = memberships.data
    console.log $scope

    $scope.deleteAssignment = (assignment) ->
      xhr = Assignment.get assignment.id

      # TODO: apply rules in policy
      xhr.then (assignment) ->
        assignment.delete()
          .then -> $route.reload()

    $scope.nonAssignees = (membership) ->
      # Does not belong to the task
      _.find($scope.assignments, (x) -> x.userId == membership.userId) == undefined

    $scope.saveTask = ->
      $scope.task.save()
        .then (task) ->
          $location.path $scope.path 'ProjectTaskIndexCtrl',
            projectId: $scope.project.id
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash =
              type: 'danger'
              message: "#{err.data._message} (#{err.status})"
]
