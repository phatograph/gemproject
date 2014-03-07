class Project < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :tasks, :dependent => :destroy
  after_save :add_owner_as_member

  STATUSES = [
    'New',         # 0
    'In progress', # 1
    'Completed',   # 2
    'On hold',     # 3
    'Cancelled'    # 4
  ]

  def status_text
    STATUSES[status]
  end

  def self.statuses_object
    STATUSES.each_with_index.map do |status, i|
      {
        :id => i,
        :name => status
      }
    end
  end

  def tasks_count
    tasks.count
  end

  def member?(user)
    memberships.find_by_user_id(user.id) if user
  end

  private

  def add_owner_as_member
    if owner
      unless member?(owner)
        users << owner
      end
    end
  end
end
