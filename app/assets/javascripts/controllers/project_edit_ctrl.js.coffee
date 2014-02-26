angular.module('app.controllers').controller 'ProjectEditCtrl', [
  '$scope', 'project', '$location', 'users', 'Membership', '$route', 'memberships',
  ($scope, project, $location, users, Membership, $route, memberships) ->

    $scope.project = project.data
    $scope.users = users.data
    $scope.memberships = memberships.data

    $scope.deleteMember = (membership) ->
      xhr = Membership.get membership.id
      xhr.then (membership) ->
        membership.delete()
          .then -> $route.reload()

    $scope.nonMembers = (user) ->
      # Does not belong to the project
      _.find($scope.memberships, (m) -> m.userId == user.id) == undefined

    $scope.saveProject = ->
      $scope.project.save()
        .then (project) ->
          $location.path $scope.path 'UserIndexCtrl'
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash =
              type: 'danger'
              message: "#{err.data._message} (#{err.status})"

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

  tasks: [
    '$q', 'Task', '$route',
    ($q, Task, $route) ->

      deferred = $q.defer()

      xhr = Task.get projectId: $route.current.params.projectId
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

  memberships: [
    '$q', 'Membership', '$route',
    ($q, Membership, $route) ->

      deferred = $q.defer()

      xhr = Membership.query projectId: $route.current.params.projectId
      xhr.then (data) -> deferred.resolve status: 200, data: data
      xhr.catch (error) -> deferred.resolve status: 404, data: error.data

      deferred.promise
  ]
