class Timelog < ActiveRecord::Base
  belongs_to :assignment

  scope :running, -> { where("ended_at IS NULL") }
  scope :stopped, -> { where("ended_at IS NOT NULL") }

  def total_time
    if ended_at?
      diff = ended_at - started_at
      Time.at(diff).utc.strftime("%H:%M:%S")
    end
  end
end
