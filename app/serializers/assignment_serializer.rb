class AssignmentSerializer < ApplicationSerializer
  attributes :id,
    :task_id,
    :user_id,
    :running?,
    :total_time,
    :_startable,
    :_stoppable

  has_one :user
  has_many :timelogs

  def _startable
    policy(object).start?
  end

  def _stoppable
    policy(object).stop?
  end
end
