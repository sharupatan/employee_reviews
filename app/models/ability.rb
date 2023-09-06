# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.super_admin?
      can :manage, User
      can :manage, Review
    elsif user.admin?
      can :manage, User, id: user.id
      cannot :destroy, User
      can :manage, Review
    else
      can :manage, User, id: user.id
      can :manage, Review, user_id: user.id
    end
  end
end
