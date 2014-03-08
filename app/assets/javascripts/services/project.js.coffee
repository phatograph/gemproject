angular.module('app.services').factory 'Project', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    resource = railsResourceFactory
      url: Routes.api_project_path '{{ id }}'
      name: 'project'

    resource.byRequesterDepartment = (query) ->
      @$get "#{@$url()}/by_requester_department", query

    return resource
  ]
