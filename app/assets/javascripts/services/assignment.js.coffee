angular.module('app.services').factory 'Assignment', [
  'railsResourceFactory', 'railsSerializer', '$http',
  (railsResourceFactory, railsSerializer, $http) ->

    resource = railsResourceFactory
      url: Routes.api_assignment_path '{{ id }}'
      name: 'assignment'

    resource::start = ->
      @$post "#{@$url()}/start"

    resource::stop = ->
      @$put "#{@$url()}/stop"

    return resource
  ]