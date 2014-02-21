angular.module('app.controllers').controller 'ProjectMembershipCtrl', [
  '$scope', 'project', 'users', 'Membership', '$route', 'memberships',
  ($scope, project, users, Membership, $route, memberships) ->

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

  ]

resolvers.ProjectMembershipResolver =
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

  memberships: [
    '$q', 'Membership', '$route',
    ($q, Membership, $route) ->

      deferred = $q.defer()

      xhr = Membership.query projectId: $route.current.params.projectId
      xhr.then (data) -> deferred.resolve status: 200, data: data
      xhr.catch (error) -> deferred.resolve status: 404, data: error.data

      deferred.promise

  ]
