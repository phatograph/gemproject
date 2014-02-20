class Api::MembershipsController < Api::BaseController
  protected

  def permitted_params
    params.permit(:membership => [
      :project_id,
      :user_id
    ])
  end
end
