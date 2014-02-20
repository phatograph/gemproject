class UserSerializer < ApplicationSerializer
  attributes :id,
             :first_name,
             :last_name,
             :email,
             :position,
             :employee_number,
             :department,
             :full_name,

             :_createable,
             :_updateable,
             :_deleteable

  def full_name
    "#{first_name} #{last_name}"
  end
end
