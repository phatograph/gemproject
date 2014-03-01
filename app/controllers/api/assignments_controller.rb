class Api::AssignmentsController < Api::BaseController
  custom_actions :resource => [:start, :stop]

  def index
    task_id = params[:task_id]
    user_id = params[:user_id]
    query   = {}

    if task_id.blank? and user_id.blank?
      raise Pundit::NotAuthorizedError
    end

    if task_id
      authorize Task.find(params[:task_id]), :show?
      query[:task_id] = task_id
    end

    if user_id
      authorize User.find(params[:user_id]), :show?
      query[:user_id] = user_id
    end

    render :json => policy_scope(Assignment.where(query))
  end

  def start
    resource.start
    render :json => @assignment
  end

  def stop
    resource.stop
    render :json => @assignment
  end

  def create
    assignment_params = permitted_params[:assignment]
    task              = Task.find assignment_params[:task_id]
    user              = User.find assignment_params[:user_id]

    authorize task, :update?
    authorize user, :update?

    assignment = Assignment.create do |assignment|
      assignment.task = task
      assignment.user = user
    end

    render :json => assignment
  end

  protected

  def permitted_params
    params.permit(:assignment => [
      :task_id,
      :user_id
    ])
  end
end
