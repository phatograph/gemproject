angular.module('app.directives').directive 'assignmentDropdown', [
  'Assignment', '$route',
  (Assignment, $route) ->
    restrict: 'A'
    link: (scope, elem, attr) ->
      elem.bind 'change', ->
        xhr = new Assignment
          taskId: scope.task.id
          userId: scope.assignment.id

        xhr.create()
          .then -> $route.reload()
]
