class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      can :manage, User, id: user.id
      can :read, :all
      if user.has_role? :dev
        can :create, App
        can :create, Endorsement
        can :manage, App, users: {id: user.id}
      end
    end
  end
end
