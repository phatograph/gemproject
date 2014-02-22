class ProjectSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :tasks_count
end
