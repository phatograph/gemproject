angular.module('app.services').factory 'Project', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    railsResourceFactory
      url: Routes.api_project_path '{{ id }}'
      name: 'project'

  ]
