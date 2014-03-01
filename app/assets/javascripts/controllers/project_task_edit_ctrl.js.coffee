angular.module('app.controllers').controller 'ProjectTaskEditCtrl', [
  '$scope', '$location', '$route', 'project', 'task', 'assignments', 'memberships', 'my_assignment',
  ($scope, $location, $route, project, task, assignments, memberships, my_assignment) ->
    $scope.project       = project.data
    $scope.task          = task.data
    $scope.assignments   = assignments.data
    $scope.my_assignment = my_assignment.data
    $scope.memberships   = memberships.data

    $scope.startTimelog = (assignment) ->
      assignment.start()
        .then -> $route.reload()

    $scope.stopTimelog = (assignment) ->
      assignment.stop()
        .then -> $route.reload()

    $scope.deleteAssignment = (assignment) ->
      # TODO: apply rules in policy
      assignment.delete()
        .then -> $route.reload()

    $scope.nonAssignees = (membership) ->
      # Does not belong to the task
      _.find($scope.assignments, (x) -> x.userId == membership.userId) == undefined

    $scope.saveTask = ->
      $scope.task.save()
        .then (task) ->
          $location.path $scope.path 'ProjectTaskShowCtrl',
            projectId: $scope.project.id
            taskId: task.id
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash =
              type: 'danger'
              message: "#{err.data._message} (#{err.status})"
]
