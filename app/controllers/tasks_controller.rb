class TasksController < ApplicationController
  load_and_authorize_resource :subject
  load_and_authorize_resource :task

  def show
  end
end
