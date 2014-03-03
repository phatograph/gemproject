class TaskPolicy < ApplicationPolicy
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
    user.present?
  end

  def status_changeable?
    record.assignments.any? do |assignment|
      assignment.running?
    end
  end
end
