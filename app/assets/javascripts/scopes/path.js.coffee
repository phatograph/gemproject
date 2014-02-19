angular.module('app').run [
  '$route', '$rootScope',
  ($route, $rootScope) ->

    _paths = {}
    paramsRe = new RegExp /\:(\w+)/g
    for path of $route.routes
      controller = $route.routes[path].controller
      if controller?
        _paths[controller] ?= []
        _paths[controller].push
          path: path
          paramsKeys: (m[1] while m = paramsRe.exec path).sort()

    $rootScope.path = (controller, params) ->
      for pathInfo in _paths[controller]
        keys = []

        if params?
          for key, value of params
            keys.push key if value?

        keys = keys.sort()
        if angular.equals keys, pathInfo.paramsKeys
          result = pathInfo.path
          result = result.replace ":#{p}", params[p] for p of params
          return result

  ]
