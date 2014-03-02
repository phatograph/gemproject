class AssignmentSerializer < ApplicationSerializer
  attributes :id,
    :task_id,
    :user_id,
    :running?,
    :total_time,
    :_startable,
    :_stoppable,
    :_destroyable_all_timelogs

  has_one :user
  has_many :timelogs

  def _startable
    policy(object).start?
  end

  def _stoppable
    policy(object).stop?
  end

  def _destroyable_all_timelogs
    policy(object).delete_all_timelogs?
  end
end
