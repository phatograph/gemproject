class Api::AttachmentsController < Api::BaseController
  def create
    attachment = Attachment.create do |a|
      a.attachment = permitted_params[:file]
    end

    render :json => attachment
  end

  protected

  def permitted_params
    params.permit(:file, :task_id)
  end
end
