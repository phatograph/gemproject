angular.module('app.services').factory 'Timelog', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    railsResourceFactory
      url: Routes.api_timelog_path '{{ id }}'
      name: 'timelog'

  ]
