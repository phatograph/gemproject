angular.module('app.controllers').controller 'ProjectTaskShowCtrl', [
  '$scope', 'task', 'project', '$route', 'assignments',
  ($scope, task, project, $route, assignments) ->
    $scope.project = project.data
    $scope.tasks = task.data
    $scope.assignments = assignments.data
]

resolvers.ProjectTaskIndexResolver =
  project: [
    '$q', 'Project', '$route',
    ($q, Project, $route) ->

      deferred = $q.defer()

      xhr = Project.get $route.current.params.projectId
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

