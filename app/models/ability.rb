class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    
    if user.supervisor?
      can :read, :all
      can [:edit, :update, :destroy], User do |other_user|
        user != other_user
      end
    else
      if namespace == "supervisor"
        cannot :manage, :all
      else
        can :read, Course
        can :read, Subject
        can :read, UserCourse, user_id: user.id
        can :read, User do |other_user|
          other_user.trainee?
        end
      end
    end
  end
end
