class AssignmentPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def mine?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present? &&
      record.timelogs.count == 0
  end

  def start?
    user.present? &&
      !record.running? &&
      user.id == record.user.id &&
      [0, 1].include?(record.task.status)
  end

  def stop?
    user.present? &&
      record.running? &&
      user.id == record.user.id &&
      [0, 1].include?(record.task.status)
  end

  def delete_all_timelogs?
    user.present? &&
      user.id == record.user.id
  end
end
