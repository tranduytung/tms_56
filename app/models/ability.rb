class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.supervisor?
      can :read, User
      can :manage, :all
    end
  end
end
