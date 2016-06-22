class UserCoursesController < ApplicationController
  load_and_authorize_resource
  
  def index
  end

  def show
    @user_courses = @user_course.course.user_courses.page(params[:page]).
      per Settings.courses.per_page
    @activities = PublicActivity::Activity.course @user_course.course
  end
end
