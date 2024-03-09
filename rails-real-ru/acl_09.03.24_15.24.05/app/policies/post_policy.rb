# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  # BEGIN
  def create?
    user
  end

  def new?
    create?
  end

  def update?
    user == record.author || user&.admin
  end

  def edit?
    update?
  end

  def destroy?
    user&.admin
  end
  # END
end
