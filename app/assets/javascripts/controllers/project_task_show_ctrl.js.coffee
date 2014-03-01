angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', 'project', '$route', 'assignments', 'my_assignment',
  'memberships', '$location',
  ($scope, task, project, $route, assignments, my_assignment, memberships,
  $location) ->
    $scope.project       = project.data
    $scope.task          = task.data
    $scope.assignments   = assignments.data
    $scope.my_assignment = my_assignment.data
    $scope.memberships = memberships.data

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

    $scope.refreshPage = ->
      $route.reload()

    $scope.deleteAssignment = (assignment) ->
      # TODO: apply rules in policy
      assignment.delete()
        .then -> $route.reload()

    $scope.nonAssignees = (membership) ->
      # Does not belong to the task
      _.find($scope.assignments, (x) -> x.userId == membership.userId) == undefined

    $scope.saveTask = ->
      $scope.task.save()
        .then -> $route.reload()
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash =
              type: 'danger'
              message: "#{err.data._message} (#{err.status})"
]
