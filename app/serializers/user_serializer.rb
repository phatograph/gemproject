class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :email,
             :password,
             :position,
             :employee_number,
             :department,
             :full_name,
             :_createable,
             :_deletable

  def full_name
    "#{first_name} #{last_name}"
  end

  def _createable
    UserPolicy.new(current_user, User).create?
  end

  def _deletable
    UserPolicy.new(current_user, object).destroy?
  end
end
