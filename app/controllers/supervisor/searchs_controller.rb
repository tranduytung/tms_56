class Supervisor::SearchsController < ApplicationController
  authorize_resource class: Course.name
  def index
    @search = Course.ransack params[:q]
    @find_course = @search.result
  end
end
