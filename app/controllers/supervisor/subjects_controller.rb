class Supervisor::SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
    subject = Subject.new
    subject.tasks.build
    @subject_form = SubjectForm.new subject
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
      flash.now[:danger] = t "subject.add_fail"
      render :index
    end
  end

  private
  def subject_params
    params.require(:subject).permit :content, :description
  end
end
