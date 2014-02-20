class Api::UsersController < Api::BaseController
  protected

  def permitted_params
    params.permit(:user => [
      :first_name,
      :last_name,
      :email,
      :password,
      :position,
      :employee_number,
      :department
    ])
  end
end
