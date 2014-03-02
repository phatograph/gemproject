class Api::ProjectsController < Api::BaseController
  protected

  def permitted_params
    params.permit(:project => [
      :name,
      :owner_id
    ])
  end
end
