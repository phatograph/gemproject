angular.module('app.services').factory 'Membership', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    railsResourceFactory
      url: Routes.api_memberships_path()
      exclusionMatchers: '_'
      name: 'membership'

  ]
