class Project < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :tasks, :dependent => :destroy
  after_save :add_owner_as_member

  def tasks_count
    tasks.count
  end

  def member?(user)
    memberships.find_by_user_id(user.id)
  end

  private

  def add_owner_as_member
    unless member?(owner)
      users << owner
    end
  end
end
