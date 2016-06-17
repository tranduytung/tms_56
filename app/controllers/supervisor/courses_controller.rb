class Supervisor::CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :load_subjects, only: [:index, :create]

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

  private
  def course_params
    params.require(:course).permit :content, :description, subject_ids: []
  end
  
  def load_subjects
    @subjects = Subject.all
  end
end
