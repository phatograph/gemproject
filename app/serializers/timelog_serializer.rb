class TimelogSerializer < ApplicationSerializer
  attributes :id,
    :started_at,
    :ended_at
end
