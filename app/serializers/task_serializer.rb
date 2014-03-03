class TaskSerializer < ApplicationSerializer
  attributes :id,
    :name,
    :body,
    :project_id,
    :status,
    :status_text,
    :content,
    :content_html,
    :created_at,
    :assignees,
    :ended_at,
    :_status_changeable

  def _status_changeable
    policy(object).status_changeable?
  end
end
