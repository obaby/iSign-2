class UserPolicy < ApplicationPolicy
  def show?
    user == record
  end

  def create
    true
  end
end
