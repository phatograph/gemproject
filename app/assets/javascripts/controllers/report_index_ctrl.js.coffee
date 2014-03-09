angular.module('app.controllers').controller 'ReportIndexCtrl', [
  '$scope', '$route', '$location', '$filter', 'Project'
  ($scope,   $route,   $location,   $filter,   Project) ->
    Project.byRequesterDepartment(
      mode: $route.current.params.mode
      startedAt: $route.current.params.startedAt
      endedAt: $route.current.params.endedAt
    ).then (data) ->
      $scope.mode = data.mode
      $scope.startedAt = data.startedAt
      $scope.endedAt = data.endedAt
      $scope.departments = data.departments

    $scope.setStartedAt = (time) ->
      $scope.setTime time, new Date($scope.endedAt)

    $scope.setEndedAt = (time) ->
      nextDay = +(moment.duration(+time).add(1439, 'm'))
      $scope.setTime new Date($scope.startedAt), nextDay

    $scope.setMode = (mode) ->
      $scope.mode = mode
      $scope.setTime()

    $scope.setTime = (start, end) ->
      $location.search
        mode: $scope.mode
        startedAt: if start? then +(start / 1000) else ''
        endedAt: if end? then +(end / 1000) else ''
]
