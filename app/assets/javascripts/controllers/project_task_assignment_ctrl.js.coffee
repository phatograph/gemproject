angular.module('app.controllers').controller 'ProjectTaskAssignmentCtrl', [
  '$scope', '$location', '$route', 'project', 'task', 'assignments', 'users', 'Assignment'
  ($scope, $location, $route, project, task, assignments, users, Assignment) ->
    $scope.project     = project.data
    $scope.task        = task.data
    $scope.assignments = assignments.data
    $scope.users       = users.data

    $scope.deleteAssignment = (assignment) ->
      xhr = Assignment.get assignment.id
      xhr.then (assignment) ->
        assignment.delete()
          .then -> $route.reload()

    # $scope.nonMembers = (user) ->
    #   # Does not belong to the project
    #   _.find($scope.assignments, (m) -> m.userId == user.id) == undefined
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

  users: [
    '$q', 'User',
    ($q, User) ->

      deferred = $q.defer()

      xhr = User.query()
      xhr.then (data) -> deferred.resolve status: 200, data: data

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
