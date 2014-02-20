angular.module('app.controllers').controller 'ProjectMembershipCtrl', [
  '$scope', 'project', '$location', 'users', 'Membership', '$route',
  ($scope, project, $location, users, Membership, $route) ->

    $scope.project = project.data
    $scope.users = users.data

    $scope.deleteMember = (membership) ->
      xhr = Membership.get membership.id
      xhr.then (membership) ->
        membership.delete()
          .then -> $route.reload()

    $scope.nonMembers = (user) ->
      # Does not belong to the project
      _.find($scope.project.memberships, (u) -> u.user.id == user.id) == undefined

  ]

resolvers.ProjectMembershipResolver =
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
