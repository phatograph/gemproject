angular.module('app.services').factory 'Project', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    railsResourceFactory
      url: Routes.api_projects_path()
      name: 'project'

  ]
