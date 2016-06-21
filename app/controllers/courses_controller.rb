class CoursesController < ApplicationController
  load_and_authorize_resource
  
  def show
    @user_courses = @course.user_courses.page(params[:page]).
      per Settings.subjects.per_page
    unless current_user.check_user_course_exits @course
      @user_course = current_user.user_courses.build
    end
  end
end
