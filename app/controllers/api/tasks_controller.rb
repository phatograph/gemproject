class Api::TasksController < Api::BaseController
  belongs_to :project
  custom_actions({
    :resource => [:detailed]
  })

  def detailed
    render :json => @task,
      :serializer => TaskDetailedSerializer,
      :root => false
  end

  protected

  def permitted_params
    params.permit(:task => [
      :name,
      :body,
      :status,
      :content
    ])
  end
end
