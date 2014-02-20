class ProjectSerializer < ApplicationSerializer
  attributes :id,
             :name

  has_many :memberships
end
