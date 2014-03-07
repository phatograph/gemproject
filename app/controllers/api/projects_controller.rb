class Api::ProjectsController < Api::BaseController
  protected

  def permitted_params
    params.permit(:project => [
      :name,
      :owner_id,
      :requester_name,
      :requester_department,
      :status
    ])
  end
end
