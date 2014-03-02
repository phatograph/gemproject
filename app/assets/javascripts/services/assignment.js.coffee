angular.module('app.services').factory 'Assignment', [
  'railsResourceFactory', 'railsSerializer', '$http',
  (railsResourceFactory, railsSerializer, $http) ->

    resource = railsResourceFactory
      url: Routes.api_assignment_path '{{ id }}'
      name: 'assignment'
      serializer: railsSerializer () ->
        @resource 'timelogs', 'Timelog'

    resource::start = ->
      @$post "#{@$url()}/start"

    resource::stop = ->
      @$put "#{@$url()}/stop"

    resource::deleteAllTimelogs = ->
      @$delete "#{@$url()}/delete_all_timelogs"

    resource.mine = (taskId) ->
      @$get "#{@$url()}/mine?task_id=#{taskId}",

    return resource
  ]
