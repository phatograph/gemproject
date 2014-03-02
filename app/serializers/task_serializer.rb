class TaskSerializer < ApplicationSerializer
  attributes :id,
    :name,
    :body,
    :project_id,
    :status,
    :status_text,
    :content,
    :content_html,
    :running?

  # has_many :assignments
end
