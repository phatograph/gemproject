angular.module('app.services').factory 'Attachment', [
  'railsResourceFactory', 'railsSerializer',
  (railsResourceFactory, railsSerializer) ->

    railsResourceFactory
      url: Routes.api_attachment_path '{{ id }}'
      name: 'attachment'

  ]
