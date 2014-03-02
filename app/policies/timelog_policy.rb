class TimelogPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    user.present?
  end

  def update?
    user.present? && record.assignment.user_id == user.id
  end

  def destroy?
    user.present? && record.assignment.user_id == user.id
  end
end
