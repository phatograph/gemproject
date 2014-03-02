class MembershipPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present? &&
      record.tasks.count == 0
  end
end
