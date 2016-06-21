class CoursesController < ApplicationController
  load_and_authorize_resource
  
  def show
    @user_courses = @course.user_courses.page(params[:page]).
      per Settings.subjects.per_page
  end
end
