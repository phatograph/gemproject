class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  # Error handling.
  rescue_from Pundit::NotAuthorizedError, :with => :not_authorized

  protected

  # Response 401 error.
  def not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to request.referer || root_url
  end
end
