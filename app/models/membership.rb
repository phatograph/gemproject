class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :tasks,
    :through => :user

  validates_presence_of :user_id, :project_id
  validates_uniqueness_of :user_id, :scope => :project_id

  after_destroy do |membership|
    membership.user.tasks.destroy_all
  end
end
