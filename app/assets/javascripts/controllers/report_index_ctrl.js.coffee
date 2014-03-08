angular.module('app.controllers').controller 'ReportIndexCtrl', [
  '$scope', '$route', '$location', '$filter', 'Project'
  ($scope,   $route,   $location,   $filter,   Project) ->
    Project.byRequesterDepartment(
      startedAt: $route.current.params.startedAt
      endedAt: $route.current.params.endedAt
    ).then (data) ->
      console.log data
      $scope.startedAt = data.startedAt
      $scope.endedAt = data.endedAt
      $scope.departments = data.departments

    $scope.setStartedAt = (time) ->
      $scope.setTime time, new Date($scope.endedAt)

    $scope.setEndedAt = (time) ->
      $scope.setTime new Date($scope.startedAt), time

    $scope.setTime = (startedAt, endedAt) ->
      $location.search
        startedAt: +(startedAt / 1000)
        endedAt: +(endedAt / 1000)
]
