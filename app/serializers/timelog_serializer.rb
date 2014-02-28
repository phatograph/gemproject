class TimelogSerializer < ApplicationSerializer
  attributes :id,
    :started_at,
    :ended_at,
    :total_time
end
