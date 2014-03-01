class Api::TasksController < Api::BaseController
  belongs_to :project

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
