angular.module('app.services').factory 'User', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    railsResourceFactory
      url: Routes.api_user_path '{{ id }}'
      name: 'user'

  ]
