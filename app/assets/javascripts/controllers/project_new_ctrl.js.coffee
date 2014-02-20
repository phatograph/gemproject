angular.module('app.controllers').controller 'ProjectNewCtrl', [
  '$scope', 'Project', '$location',
  ($scope, Project, $location) ->

    $scope.project = new Project()
    $scope.saveProject = ->
      $scope.project.create()
        .then (project) ->
          $location.path $scope.path 'UserIndexCtrl'
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash = type: 'danger', message: "#{err.data._message} (#{err.status})"

  ]

