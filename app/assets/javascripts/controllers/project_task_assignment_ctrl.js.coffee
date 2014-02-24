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

resolvers.ProjectAssignmentResolver =
  project: [
    '$q', 'Project', '$route',
    ($q, Project, $route) ->

      deferred = $q.defer()

      xhr = Project.get $route.current.params.projectId
      xhr.then (data) -> deferred.resolve status: 200, data: data
      xhr.catch (error) -> deferred.resolve status: 404, data: error.data

      deferred.promise
  ]

  memberships: [
    '$q', 'Membership', '$route',
    ($q, Membership, $route) ->

      deferred = $q.defer()

      xhr = Membership.query projectId: $route.current.params.projectId
      xhr.then (data) -> deferred.resolve status: 200, data: data
      xhr.catch (error) -> deferred.resolve status: 404, data: error.data

      deferred.promise
  ]

  task: [
    '$q', 'Task', '$route',
    ($q, Task, $route) ->

      deferred = $q.defer()

      xhr = Task.get
        projectId: $route.current.params.projectId
        id: $route.current.params.taskId
      xhr.then (data) -> deferred.resolve status: 200, data: data
      xhr.catch (error) -> deferred.resolve status: 404, data: error.data

      deferred.promise
  ]

  assignments: [
    '$q', 'Assignment', '$route',
    ($q, Assignment, $route) ->

      deferred = $q.defer()

      xhr = Assignment.query taskId: $route.current.params.taskId
      xhr.then (data) -> deferred.resolve status: 200, data: data
      xhr.catch (error) -> deferred.resolve status: 404, data: error.data

      deferred.promise
  ]
