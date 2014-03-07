angular.module('app.controllers').controller 'ProjectNewCtrl', [
  '$scope', '$location', 'users', 'Project', 'projects'
  ($scope,   $location,   users,   Project,   projects) ->
    $scope.project = new Project()
    $scope.users = users.data
    $scope.requesterNames = _.uniq(p.requesterName for p in projects.data when p.requesterName?) or []
    $scope.requesterDepts = _.uniq(p.requesterDepartment for p in projects.data when p.requesterDepartment?) or []

    $scope.saveProject = ->
      $scope.project.create()
        .then (project) ->
          $location.path $scope.path 'ProjectEditCtrl', projectId: project.id
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash = type: 'danger', message: "#{err.data._message} (#{err.status})"

]
