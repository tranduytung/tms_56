class Supervisor::CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :load_subjects, except: [:new, :show, :destroy]

  def index
    @courses = @courses.page(params[:page]).per Settings.courses.per_page
    @course = Course.new
  end

  def show
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
        format.html {redirect_to supervisor_courses_path}
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
    params.require(:course).permit :content, :description, subject_ids: []
  end

  def load_subjects
    @subjects = Subject.all.page(params[:subject_page]).per Settings.courses.per_page
  end
end
