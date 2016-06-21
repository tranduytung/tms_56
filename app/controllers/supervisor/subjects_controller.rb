class Supervisor::SubjectsController < ApplicationController
  load_and_authorize_resource
  before_action :load_subject_form, only: [:edit, :update]

  def index
    @subjects = @subjects.page(params[:page]).per Settings.subjects.per_page
    subject = Subject.new
    subject.tasks.build
    @subject_form = SubjectForm.new subject
  end

  def show
  end

  def create
    @subject = Subject.new
    params[:subject][:tasks_attributes].each do |_, value|
      @subject.tasks.build
    end
    @subject_form = SubjectForm.new @subject
    if @subject_form.validate params[:subject].permit!
      @subject_form.save
      flash[:success] = t "subject.add_success"
      redirect_to supervisor_subjects_path
    else
      @subjects = Subject.all.page(params[:page]).per Settings.subjects.per_page
      flash.now[:danger] = t "subject.add_fail"
      render :index
    end
  end

  def edit
  end

  def update
    if @subject_form.validate params[:subject].permit!
      @subject_form.save
      flash[:success] = t "subject.edit_success"
      redirect_to supervisor_subjects_path
    else
      flash.now[:danger] = t "subject.edit_fail"
      render :edit
    end
  end

  private
  def subject_params
    params.require(:subject).permit :content, :description
  end

  def load_subject_form
    @subject_form = SubjectForm.new Subject.find params[:id]
  end
end
