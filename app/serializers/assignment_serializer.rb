class AssignmentSerializer < ApplicationSerializer
  attributes :id,
    :task_id,
    :user_id

  has_one :user
end
