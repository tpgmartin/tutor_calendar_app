class Ability
  include CanCan::Ability

  # TODO: Finish assignment of user roles
  def initialize(user)
    user ||= User.new
    if user.role? :guest
      can :create, User
    end
    if user.role? :parent
      can :manage, User, :user_id => user.id
      can [:read, :update, :destroy], Relationship
      
    end
    if user.role? :parent
      can :manage, :all
    end
    if user.role? :tutor
      can :create, Relationship
    end
    if user.role? :admin
      can :manage, :all
    end
  end
end
