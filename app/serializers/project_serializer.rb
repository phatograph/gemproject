class ProjectSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :owner_id

  has_one :owner
end
