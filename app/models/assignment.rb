class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :timelogs, :dependent => :destroy

  validates_presence_of :user_id, :task_id
  validates_uniqueness_of :user_id, :scope => :task_id
end
