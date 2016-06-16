class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.supervisor?
      can :read, User
      can :manage, :all
    elsif user.trainee?
      can :read, Course
      can :read, Subject
      can :read, UserCourse, user_id: user.id
    end
  end
end
