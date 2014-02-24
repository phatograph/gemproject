angular.module('app.services').factory 'Assignment', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    railsResourceFactory
      url: Routes.api_assignment_path '{{ id }}'
      name: 'assignment'

  ]
