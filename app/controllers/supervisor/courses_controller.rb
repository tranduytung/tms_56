class Supervisor::CoursesController < ApplicationController
  load_and_authorize_resource

  def index
    @course = Course.new
    @course.build_course_subjects @course.subjects
    @search = @courses.ransack params[:q]
    unless params[:q].nil?
      @courses = @search.result.page(params[:page]).per Settings.courses.per_page
    end
  end

  def show
  end

  def edit
    @course.build_course_subjects @course.subjects
  end

  def create
    if @course.save
      flash[:success] = t "courses.create_success"
      redirect_to supervisor_courses_path
    else
      @courses = Course.all.page(params[:page]).per Settings.courses.per_page
      flash.now[:danger] = t "courses.create_error"
      render :index
    end
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "courses.update_success"
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    else
      @courses = Course.all.page(params[:page]).per Settings.courses.per_page
      flash.now[:danger] = t "courses.update_error"
      render :index
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t "courses.delete_success"
    else
      flash[:danger] = t "courses.delete_error"
    end
    redirect_to supervisor_courses_path
  end

  private
  def course_params
    params.require(:course).permit :content, :description, :status,
      course_subjects_attributes: [:id, :subject_id, :course_id, :status, :_destroy]
  end
end
