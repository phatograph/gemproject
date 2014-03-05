angular.module('app.directives').directive 'assignmentDropdown', [
  'Assignment', '$route',
  (Assignment, $route) ->
    restrict: 'A'
    link: (scope, elem, attr) ->
      elem.bind 'change', ->
        elem.prop 'disabled', true
        xhr = new Assignment
          taskId: scope.task.id
          userId: scope.assignment.userId  # membership object

        # TODO: apply rules in policy
        xhr.create()
          .then -> $route.reload()
]
