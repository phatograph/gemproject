angular.module('app.controllers').controller 'ReportIndexCtrl', [
  '$scope', '$route', '$location', '$filter', 'Project'
  ($scope,   $route,   $location,   $filter,   Project) ->
    Project.byRequesterDepartment(
      startedAtStart: $route.current.params.startedAtStart
      startedAtEnd: $route.current.params.startedAtEnd
    ).then (data) ->
      $scope.startedAtStart = data.startedAtStart
      $scope.startedAtEnd = data.startedAtEnd
      $scope.departments = data.departments

    $scope.setStartedAtStart = (time) ->
      $scope.setTime time, new Date($scope.startedAtEnd)

    $scope.setStartedAtEnd = (time) ->
      $scope.setTime new Date($scope.startedAtStart), time

    $scope.setTime = (start, end) ->
      $location.search
        startedAtStart: +(start / 1000)
        startedAtEnd: +(end / 1000)
]
