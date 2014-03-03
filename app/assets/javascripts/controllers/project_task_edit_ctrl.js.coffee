angular.module('app.controllers').controller 'ProjectTaskEditCtrl', [
  '$scope', '$location', '$route', 'project', 'task', 'assignments', 'memberships', 'my_assignment',
  ($scope, $location, $route, project, task, assignments, memberships, my_assignment) ->
    $scope.project       = project.data
    $scope.task          = task.data
    $scope.assignments   = assignments.data
    $scope.my_assignment = my_assignment.data
    $scope.memberships   = memberships.data

    # Need to do this manually, chaining associated models serialization
    # seems not to be a good idea in production
    $scope.statusChangeable =  _.any(assignments.data, 'running')

    $scope.deleteAssignment = (assignment) ->
      # TODO: apply rules in policy
      assignment.delete()
        .then -> $route.reload()
        .catch (err) ->
          if err.status is 401
            $scope.assignmentError = "* Please delete all user's timelog before remove him/her from this task."

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
