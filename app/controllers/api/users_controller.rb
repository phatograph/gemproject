class Api::UsersController < ApplicationController
  inherit_resources
  respond_to :json
  actions :all, :except => [:edit, :new]

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
