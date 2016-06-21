class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    alias_action :new, :create, :edit, :update, :destroy, to: :crud

    if user.supervisor?
      can :manage, :all
      cannot :crud, User do |other_user|
        user == other_user
      end
    else
      if namespace == "supervisor"
        cannot :manage, :all
      else
        can :read, Course
        can :read, Subject
        can :read, Task
        can :read, UserCourse, user_id: user.id
        can :read, User do |other_user|
          other_user.trainee?
        end
      end
    end
  end
end
