class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :manage, User, :id => user.id
      can :read, :all
      if user.is_dev # TODO fix this
        can :create, App
        can :manage, App, :users => {:id => user.id}
      end
    end
  end
end
