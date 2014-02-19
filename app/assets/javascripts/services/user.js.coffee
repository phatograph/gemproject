angular.module('app.services').factory 'User', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    railsResourceFactory
      url: Routes.api_users_path()
      exclusionMatchers: '_'
      name: 'user'

  ]
