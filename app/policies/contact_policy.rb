class ContactPolicy < ApplicationPolicy
  def show?
    record.owner?(user)
  end

  def create?
    user.present?
  end

  def update?
    record.owner?(user)
  end

  def destroy?
    record.owner?(user)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
    end
  end
end
