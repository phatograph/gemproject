angular.module('app.directives').directive 'memberDropdown', [
  'Membership', '$route',
  (Membership, $route) ->
    restrict: 'A'
    link: (scope, elem, attr) ->
      elem.bind 'change', ->
        elem.prop 'disabled', true
        xhr = new Membership
          projectId: scope.project.id
          userId: scope.membership.id

        xhr.create()
          .then -> $route.reload()
]
