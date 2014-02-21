class MembershipSerializer < ApplicationSerializer
  attributes :id,
    :project_id,
    :user_id

  has_one :user
end
