angular.module('app.directives').directive 'memberDropdown', [
  'Membership', 'User',
  (Membership, User) ->
    restrict: 'A'
    link: (scope, elem, attr) ->
      elem.bind 'change', ->
        xhr = new Membership
          projectId: scope.project.id
          userId: scope.membership.id

        xhr.create()
          .then (obj) ->
            scope.project.memberships.push obj
]
