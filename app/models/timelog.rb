class Timelog < ActiveRecord::Base
  belongs_to :assignment

  scope :running, -> { where("ended_at IS NULL") }
  scope :stopped, -> { where("ended_at IS NOT NULL") }
end
