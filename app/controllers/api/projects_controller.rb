class Api::ProjectsController < Api::BaseController
  custom_actions({
    :collection => [:by_requester_department]
  })

  def by_requester_department
    render :json => @projects.group_by(&:requester_department)
  end

  protected

  def permitted_params
    params.permit(:project => [
      :name,
      :owner_id,
      :requester_name,
      :requester_department,
      :status,
      :ended_at
    ])
  end
end
