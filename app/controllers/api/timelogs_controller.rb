class Api::TimelogsController < Api::BaseController
  protected

  def permitted_params
    params.permit(:timelog => [
      :started_at,
      :ended_at,
      :task_id
    ])
  end
end
