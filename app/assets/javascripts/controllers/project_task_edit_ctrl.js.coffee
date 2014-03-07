angular.module('app.controllers').controller 'ProjectTaskEditCtrl', [
  '$scope', '$location', '$route', '$http', '$upload', 'task', 'memberships', 'Attachment'
  ($scope,   $location,   $route,   $http,   $upload,   task,   memberships,   Attachment) ->
    $scope.memberships = memberships.data
    $scope.task        = task.data
    $scope.project     = $scope.task.project
    $scope.assignments = $scope.task.assignments
    $scope.attachments = $scope.task.attachments
    if $scope.task.myAssignment?
      $scope.myAssignment = _.find $scope.assignments, (a) ->
        a.id is $scope.task.myAssignment.id

    # Need to do this manually, chaining associated models serialization
    # seems not to be a good idea in production
    $scope.statusChangeable =  _.any $scope.assignments, (a) -> a.running

    $scope.deleteAssignment = (assignment) ->
      # TODO: apply rules in policy
      assignment.delete()
        .then -> $route.reload()
        .catch (err) ->
          if err.status is 401
            $scope.assignmentError = "* Please delete all user's timelog before remove him/her from this task."

    $scope.nonAssignees = (membership) ->
      # Does not belong to the task
      _.find($scope.assignments, (x) -> x.userId == membership.userId) == undefined

    $scope.saveTask = ->
      $scope.task.save()
        .then (task) ->
          $location.path $scope.path 'ProjectTaskShowCtrl',
            projectId: $scope.project.id
            taskId: task.id
        .catch (err) ->
          $scope.errors = err.data.errors

          if err.data._message
            $scope.flash =
              type: 'danger'
              message: "#{err.data._message} (#{err.status})"

    $scope.uploadAttachment = ($files) ->
      for file in $files
        $scope.upload = $upload.upload
          file: file
          url: Routes.api_attachments_path
            format: 'json'
            attachableType: 'task'
            attachableId: $scope.task.id
          headers: $http.defaults.headers.post
          data:
            task_id: $scope.task.id
        $scope.upload.progress (e) ->
          # console.log e.loaded, e.total
        $scope.upload.success (data) ->
          Attachment.get(id: data.attachment.id)
           .then (attachment) ->
              $scope.attachments.push attachment

    $scope.deleteAttachment = (attachment) ->
      attachment.delete()
        .then -> $route.reload()
]
