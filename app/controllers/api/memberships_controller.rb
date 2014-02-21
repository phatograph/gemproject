class Api::MembershipsController < Api::BaseController
  def index
    project_id = params[:project_id]
    user_id    = params[:user_id]
    query      = {}

    if project_id.blank? and user_id.blank?
      raise Pundit::NotAuthorizedError
    end

    if project_id
      authorize Project.find(params[:project_id]), :show?
      query[:project_id] = project_id
    end

    if user_id
      authorize User.find(params[:user_id]), :show?
      query[:user_id] = user_id
    end

    render :json => Membership.where(query)
  end

  def create
    membership_params = permitted_params[:membership]

    project = Project.find membership_params[:project_id]
    user = User.find membership_params[:user_id]

    authorize project, :update?
    authorize user, :update?

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
