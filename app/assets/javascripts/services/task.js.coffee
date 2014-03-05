angular.module('app.services').factory 'Task', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    resource = railsResourceFactory
      url: Routes.api_project_task_path '{{ projectId }}', '{{ id }}'
      name: 'task'
      serializer: railsSerializer () ->
        @resource 'assignments', 'Assignment'

    resource.detailed = (projectId, id) ->
      @$get "#{@$url(projectId, id)}/detailed",

    return resource
]
