class AssignmentSerializer < ApplicationSerializer
  attributes :id,
    :task_id,
    :user_id,
    :running?,
    :total_time

  has_one :user
  has_many :timelogs
end
