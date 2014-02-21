angular.module('app.controllers').controller 'ProjectTaskIndexCtrl', [
  '$scope', 'tasks', 'project', '$route',
  ($scope, tasks, project, $route) ->
    $scope.project = project.data
    $scope.tasks = tasks.data

    $scope.deleteTask = (task) ->
      task.delete()
        .then -> $route.reload()
        .catch (err) ->
          if err.data._message
            $scope.flash = type: 'danger', message: "#{err.data._message} (#{err.status})"

]

