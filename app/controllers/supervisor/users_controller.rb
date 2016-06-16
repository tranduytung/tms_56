class Supervisor::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.trainee.page params[:page]
  end
end
