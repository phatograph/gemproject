class ProjectSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :owner_id,
             :requester_name,
             :requester_department,
             :status,
             :status_text,
             :ended_at

  has_one :owner
end
