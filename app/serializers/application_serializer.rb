class ApplicationSerializer < ActiveModel::Serializer
  delegate :current_user, :policy, :to => :scope
  attributes :_createable, :_updateable, :_deleteable

  def _createable
    policy(object).create?
  end

  def _updateable
    policy(object).update?
  end

  def _deleteable
    policy(object).destroy?
  end
end
