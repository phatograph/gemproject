class Api::AttachmentsController < Api::BaseController
  def create
    attachable_type = params[:attachableType].classify.constantize
    attachable_id   = params[:attachableId]
    attachable      = attachable_type.find attachable_id
    authorize attachable, :update?

    attachment = Attachment.create do |a|
      a.attachment      = permitted_params[:file]
      a.attachable_type = attachable_type.to_s
      a.attachable_id   = attachable_id
    end

    render :json => attachment
  end

  protected

  def permitted_params
    params.permit(:file, :task_id)
  end
end
