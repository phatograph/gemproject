angular.module('app.services').factory 'Task', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    resource = railsResourceFactory
      url: Routes.api_project_task_path '{{ projectId }}', '{{ id }}'
      name: 'task'
      serializer: railsSerializer () ->
        @resource 'assignments', 'Assignment'

    resource.edit = (projectId, id) ->
      @$get "#{@$url(projectId, id)}/edit",

    return resource
]
