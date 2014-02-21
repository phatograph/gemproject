angular.module('app.controllers').controller 'ProjectEditCtrl', [
  '$scope', 'project', '$location',
  ($scope, project, $location) ->

    $scope.project = project.data

    $scope.saveProject = ->
      $scope.project.save()
        .then (project) ->
          $location.path $scope.path 'UserIndexCtrl'
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash = type: 'danger', message: "#{err.data._message} (#{err.status})"

  ]

resolvers.ProjectShowResolver =
  project: [
    '$q', 'Project', '$route',
    ($q, Project, $route) ->

      deferred = $q.defer()

      xhr = Project.get $route.current.params.projectId
      xhr.then (data) -> deferred.resolve status: 200, data: data
      xhr.catch (error) -> deferred.resolve status: 404, data: error.data

      deferred.promise

  ]

  tasks: [
    '$q', 'Task', '$route',
    ($q, Task, $route) ->

      deferred = $q.defer()

      xhr = Task.get projectId: $route.current.params.projectId
      xhr.then (data) -> deferred.resolve status: 200, data: data
      xhr.catch (error) -> deferred.resolve status: 404, data: error.data

      deferred.promise

  ]
