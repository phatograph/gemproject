class ProjectSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :owner_id,
             :requester_name,
             :requester_department,
             :status,
             :status_text

  has_one :owner
end
