class Supervisor::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.trainee.page params[:page]
  end

  def edit
    @role_type = User.roles
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "message.edit_trainee_success"
      redirect_to supervisor_users_path
    else
      flash[:danger] = t "message.edit_trainee_unsuccess"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :role
  end
end
