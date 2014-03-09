class Api::ProjectsController < Api::BaseController
  custom_actions({
    :collection => [:by_requester_department]
  })

  def by_requester_department
    started_at = begin
      DateTime.strptime params[:started_at], '%s'
    rescue
      DateTime.now.beginning_of_week
    end

    ended_at = begin
      DateTime.strptime params[:ended_at], '%s'
    rescue
      DateTime.now.end_of_week
    end

    range = [started_at..ended_at]
    mode = params[:mode].present? ? params[:mode] : 'started'

    query = case mode
    when 'started' then { :created_at => range }
    when 'ended'   then { :ended_at => range }
    end

    @projects = @projects.where(query)

    render :json => {
      :mode => mode,
      :started_at => started_at,
      :ended_at => ended_at,
      :departments => @projects.group_by(&:requester_department)
    }
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
