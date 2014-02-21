class TaskSerializer < ApplicationSerializer
  attributes :id,
    :name,
    :body,
    :project_id
end
