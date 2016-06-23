class SearchsController < ApplicationController
  authorize_resource class: Course.name
  def index
    @search = current_user.courses.ransack params[:q]
    @courses = @search.result
  end
end
