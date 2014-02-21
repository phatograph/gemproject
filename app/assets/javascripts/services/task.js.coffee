angular.module('app.services').factory 'Task', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    railsResourceFactory
      url: Routes.api_project_task_path '{{ projectId }}', '{{ id }}'
      name: 'task'

  ]
