class AssignmentPolicy < ApplicationPolicy
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

  def start?
    user.present? && !record.running? && user.id == record.user.id
  end

  def stop?
    user.present? && record.running? && user.id == record.user.id
  end
end
