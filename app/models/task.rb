class Task < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :project
  has_many :assignments, :dependent => :destroy
  has_many :users, :through => :assignments
end
