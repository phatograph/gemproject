class Api::TasksController < Api::BaseController
  belongs_to :project
  custom_actions({
    :resource => [:edit]
  })

  def edit
    render :json => @task, :serializer => TaskDetailedSerializer
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
