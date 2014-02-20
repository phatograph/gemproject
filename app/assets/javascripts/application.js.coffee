#= require jquery
#= require jquery_ujs
#= require js-routes
#= require lodash
#= require bootstrap
#= require angular
#= require angular-route
#= require angularjs/rails/resource
#= require_self
#= require_tree .

window.resolvers = {}

##
# Dependent modules
#
angular.module 'app', [
  'ngRoute',
  'rails',
  'app.controllers',
  'app.directives',
  'app.filters',
  'app.services',
]

##
# Module registration
#
angular.module 'app.controllers', []
angular.module 'app.directives', []
angular.module 'app.filters', []
angular.module 'app.services', []

##
# Module configuration
#
angular.module('app').config [
  '$routeProvider',
  ($routeProvider) ->

    $routeProvider.when '/',
      controller: 'UserIndexCtrl'
      templateUrl: Routes.template_path('user')
      resolve: resolvers.UserIndexResolver

    $routeProvider.when '/users/new',
      controller: 'UserNewCtrl'
      templateUrl: Routes.template_path('user_form')

    $routeProvider.when '/users/:userId/edit',
      controller: 'UserEditCtrl'
      templateUrl: Routes.template_path('user_form')
      resolve: resolvers.UserShowResolver

    $routeProvider.when '/projects/new',
      controller: 'ProjectNewCtrl'
      templateUrl: Routes.template_path('project_form')

    $routeProvider.when '/projects/:projectId/edit',
      controller: 'ProjectEditCtrl'
      templateUrl: Routes.template_path('project_form')
      resolve: resolvers.ProjectShowResolver

    $routeProvider.otherwise redirectTo: '/'

  ]

angular.module('app').config [
  '$locationProvider',
  ($locationProvider) ->
    $locationProvider.html5Mode(true)
  ]

# Attach CSRF token alongside with all POST requests.
angular.module('app').config [
  '$httpProvider',
  ($httpProvider) ->
    csrfToken = angular.element('meta[name=csrf-token]').prop('content')
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = csrfToken
    return
  ]

# Monkey-patch AngularJS to fix ng-controller and ng-include bug.
# Bug: https://github.com/angular/angular.js/issues/4431
angular.module('app').config [
  '$provide',
  ($provide) ->
    $provide.decorator 'ngControllerDirective', [
      '$delegate',
      ($delegate) ->
        $delegate[0].priority = 900
        return $delegate
      ]
  ]
