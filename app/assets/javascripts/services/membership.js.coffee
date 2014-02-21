angular.module('app.services').factory 'Membership', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    railsResourceFactory
      url: Routes.api_membership_path '{{ id }}'
      name: 'membership'

  ]
