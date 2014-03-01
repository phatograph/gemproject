resolvers.user = [
  '$q', 'User', '$route',
  ($q, User, $route) ->
    deferred = $q.defer()

    userXhr = User.get $route.current.params.userId
    userXhr.then (user) -> deferred.resolve status: 200, data: user
    userXhr.catch (error) -> deferred.resolve status: 404, data: error.data

    deferred.promise
]

resolvers.users = [
  '$q', 'User',
  ($q, User) ->
    deferred = $q.defer()
    User.get().then (users) -> deferred.resolve status: 200, data: users
    deferred.promise
]

resolvers.project = [
  '$q', 'Project', '$route',
  ($q, Project, $route) ->
    deferred = $q.defer()

    xhr = Project.get $route.current.params.projectId
    xhr.then (data) -> deferred.resolve status: 200, data: data
    xhr.catch (error) -> deferred.resolve status: 404, data: error.data

    deferred.promise
]

resolvers.projects = [
  '$q', 'Project',
  ($q, Project) ->
    deferred = $q.defer()
    Project.get().then (projects) -> deferred.resolve status: 200, data: projects
    deferred.promise
]

resolvers.task = [
  '$q', 'Task', '$route',
  ($q, Task, $route) ->
    deferred = $q.defer()

    xhr = Task.get
      projectId: $route.current.params.projectId
      id: $route.current.params.taskId
    xhr.then (data) -> deferred.resolve status: 200, data: data
    xhr.catch (error) -> deferred.resolve status: 404, data: error.data

    deferred.promise
]

resolvers.tasks = [
  '$q', 'Task', '$route',
  ($q, Task, $route) ->
    deferred = $q.defer()

    xhr = Task.get projectId: $route.current.params.projectId
    xhr.then (data) -> deferred.resolve status: 200, data: data
    xhr.catch (error) -> deferred.resolve status: 404, data: error.data

    deferred.promise
]

resolvers.memberships = [
  '$q', 'Membership', '$route',
  ($q, Membership, $route) ->
    deferred = $q.defer()

    xhr = Membership.query projectId: $route.current.params.projectId
    xhr.then (data) -> deferred.resolve status: 200, data: data
    xhr.catch (error) -> deferred.resolve status: 404, data: error.data

    deferred.promise
]

resolvers.my_assignment = [
  '$q', 'Assignment', '$route',
  ($q, Assignment, $route) ->
    deferred = $q.defer()

    xhr = Assignment.mine $route.current.params.taskId
    xhr.then (data) -> deferred.resolve status: 200, data: data[0]
    xhr.catch (error) -> deferred.resolve status: 404, data: error.data

    deferred.promise
]

resolvers.assignments = [
  '$q', 'Assignment', '$route',
  ($q, Assignment, $route) ->
    deferred = $q.defer()

    xhr = Assignment.query taskId: $route.current.params.taskId
    xhr.then (data) -> deferred.resolve status: 200, data: data
    xhr.catch (error) -> deferred.resolve status: 404, data: error.data

    deferred.promise
]
