#= require jquery
#= require jquery_ujs
#= require js-routes
#= require lodash
#= require nprogress
#= require bootstrap
#= require moment-with-langs
#= require moment-timezone
#= require angular
#= require angular-moment
#= require angular-route
#= require angularjs/rails/resource
#= require datetimepicker
#= require_self
#= require_tree .

window.resolvers = {}

##
# Dependent modules
#
angular.module 'app', [
  'ngRoute'
  'rails'
  'angularMoment'
  'ui.bootstrap.datetimepicker'
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.services'
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
      resolve:
        users: resolvers.users
        projects: resolvers.projects

    $routeProvider.when '/users/new',
      controller: 'UserNewCtrl'
      templateUrl: Routes.template_path('user_form')

    $routeProvider.when '/users/:userId/edit',
      controller: 'UserEditCtrl'
      templateUrl: Routes.template_path('user_form')
      resolve:
        user: resolvers.user

    $routeProvider.when '/projects/new',
      controller: 'ProjectNewCtrl'
      templateUrl: Routes.template_path('project_form')
      resolve:
        users: resolvers.users

    $routeProvider.when '/projects/:projectId/edit',
      controller: 'ProjectEditCtrl'
      templateUrl: Routes.template_path('project_form')
      resolve:
        project: resolvers.project
        users: resolvers.users
        memberships: resolvers.memberships

    $routeProvider.when '/projects/:projectId/tasks',
      controller: 'ProjectTaskIndexCtrl'
      templateUrl: Routes.template_path('project_task')
      resolve:
        tasks: resolvers.tasks
        project: resolvers.project

    $routeProvider.when '/projects/:projectId/tasks/new',
      controller: 'ProjectTaskNewCtrl'
      templateUrl: Routes.template_path('project_task_form')
      resolve:
        project: resolvers.project

    $routeProvider.when '/projects/:projectId/tasks/:taskId',
      controller: 'ProjectTaskShowCtrl'
      templateUrl: Routes.template_path('project_task_show')
      resolve:
        project: resolvers.project
        task: resolvers.task
        assignments: resolvers.assignments
        myAssignment: resolvers.myAssignment

    $routeProvider.when '/projects/:projectId/tasks/:taskId/edit',
      controller: 'ProjectTaskEditCtrl'
      templateUrl: Routes.template_path('project_task_form')
      resolve:
        task: resolvers.taskEdit
        memberships: resolvers.memberships

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

    # Trigger loader
    interceptor = ['$q', '$injector', ($q, $injector) ->
      success = (response) ->
        $http = $http || $injector.get('$http')
        if $http.pendingRequests.length < 1
          NProgress.done()
        response
      error = (response) ->
        $http = $http || $injector.get('$http')
        if $http.pendingRequests.length < 1
          NProgress.done()
        $q.reject(response)

      (promise) ->
        NProgress.start()
        promise.then(success, error)
      ]
    $httpProvider.responseInterceptors.push(interceptor)


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
