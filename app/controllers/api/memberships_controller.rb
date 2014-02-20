class Api::MembershipsController < Api::BaseController
  def create
    membership_params = permitted_params[:membership]

    user = User.find membership_params[:user_id]
    project = Project.find membership_params[:project_id]

    authorize user, :update?
    authorize project, :update?

    membership = Membership.create do |membership|
      membership.user    = user
      membership.project = project
    end

    render :json => membership
  end

  protected

  def permitted_params
    params.permit(:membership => [
      :project_id,
      :user_id
    ])
  end
end
