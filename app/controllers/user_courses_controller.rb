class UserCoursesController < ApplicationController
  load_and_authorize_resource
  
  def index
  end

  def create
    @user_course.user_id = current_user.id
    if @user_course.save
      flash[:success] = t "message.join_a_course_success"
    else
      flash[:danger] = t "message.join_a_course_unsuccess"
    end
    redirect_to course_path(@user_course.course_id)
  end

  private
  def user_course_params
    params.require(:user_course).permit :course_id
  end
end
