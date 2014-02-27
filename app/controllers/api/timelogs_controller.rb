class Api::TimelogsController < Api::BaseController
  def create
    task = Task.find permitted_params[:timelog][:task_id]
    authorize task, :update?

    assignment = Assignment.where(
      :user_id => current_user.id,
      :task_id => task.id
    ).first
    authorize assignment, :update?

    authorize Timelog, :create?
    timelog = Timelog.create do |timelog|
      timelog.assignment = assignment
      timelog.started_at = DateTime.now.to_time  # solve usec
    end

    render :json => timelog
  end

  protected

  def permitted_params
    params.permit(:timelog => [
      :started_at,
      :ended_at,
      :task_id
    ])
  end
end
