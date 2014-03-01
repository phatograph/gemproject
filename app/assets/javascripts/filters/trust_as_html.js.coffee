angular.module('app.filters').filter 'trustAsHtml', [
  '$sce',
  ($sce) ->

    (input) -> $sce.trustAsHtml(input)

  ]
