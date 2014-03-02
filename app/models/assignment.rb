class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :timelogs, :dependent => :destroy

  validates_presence_of :user_id, :task_id
  validates_uniqueness_of :user_id, :scope => :task_id

  def start
    timelogs.create do |timelog|
      timelog.started_at = DateTime.now
    end

    # Automatically starts a task
    if task.status != 1
      task.status = 1
      task.save
    end
  end

  def stop
    if timelog = timelogs.running.last
      timelog.ended_at = DateTime.now
      timelog.save
    end
  end

  def running?
    timelogs.running.any?
  end

  def total_time
    sum = timelogs.stopped.to_a.sum do |timelog|
      timelog.ended_at - timelog.started_at
    end

    Time.at(sum).utc.strftime("%H:%M:%S")
  end

  def delete_all_timelogs!
    timelogs.destroy_all
  end
end
