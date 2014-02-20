angular.module('app.controllers').controller 'ProjectEditCtrl', [
  '$scope', 'project', '$location', 'users', 'Membership', '$route',
  ($scope, project, $location, users, Membership, $route) ->

    $scope.project = project.data
    $scope.users = users.data

    $scope.saveProject = ->
      $scope.project.save()
        .then (project) ->
          $location.path $scope.path 'UserIndexCtrl'
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash = type: 'danger', message: "#{err.data._message} (#{err.status})"

    $scope.deleteMember = (membership) ->
      xhr = Membership.get membership.id
      xhr.then (membership) ->
        membership.delete()
          .then -> $route.reload()

  ]

resolvers.ProjectShowResolver =
  project: [
    '$q', 'Project', '$route',
    ($q, Project, $route) ->

      deferred = $q.defer()
      projectXhr = Project.get $route.current.params.projectId

      projectXhr.then (project) -> deferred.resolve status: 200, data: project
      projectXhr.catch (error) -> deferred.resolve status: 404, data: error.data
      deferred.promise

  ]

  users: [
    '$q', 'User',
    ($q, User) ->

      deferred = $q.defer()
      User.query().then (users) ->
        deferred.resolve
          status: 200
          data: users

      deferred.promise
  ]