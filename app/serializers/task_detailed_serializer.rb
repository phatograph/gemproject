class TaskEditSerializer < ApplicationSerializer
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
    :my_assignment

  has_one :project
  has_many :assignments

  def my_assignment
    object.assignments.where(:user => current_user).first
  end
end
