class SubjectsController < ApplicationController
  load_and_authorize_resource :subject
  load_and_authorize_resource :course

  def show
  end
end
