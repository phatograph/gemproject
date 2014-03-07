angular.module('app.controllers').controller 'ReportIndexCtrl', [
  '$scope', '$route', 'Project'
  ($scope,   $route,   Project) ->
    $scope.startedAt = $scope.endedAt = new Date()

    Project.byRequesterDepartment()
      .then (departments) ->
        $scope.departments = departments
]
