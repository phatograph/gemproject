class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
         # :registerable

  validates_presence_of :first_name,
    :last_name

  has_many :memberships, :dependent => :destroy
  has_many :assignments, :dependent => :destroy
  has_many :projects, :through => :memberships
  has_many :tasks, :through => :assignments

  def full_name
    "#{first_name} #{last_name}"
  end
end
