class Api::ProjectsController < Api::BaseController
  custom_actions({
    :collection => [:by_requester_department]
  })

  def by_requester_department
    started_at_start = begin
      DateTime.strptime params[:started_at_start], '%s'
    rescue
      DateTime.now.beginning_of_week
    end

    started_at_end = begin
      DateTime.strptime params[:started_at_end], '%s'
    rescue
      DateTime.now.end_of_week
    end

    range = [started_at_start..started_at_end]
    mode = params[:mode].present? ? params[:mode] : 'started'

    query = case mode
    when 'started' then { :created_at => range }
    when 'ended'   then { :ended_at => range }
    end

    @projects = @projects.where(query)

    render :json => {
      :mode => mode,
      :started_at_start => started_at_start,
      :started_at_end => started_at_end,
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
