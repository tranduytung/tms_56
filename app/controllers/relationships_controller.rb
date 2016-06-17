class RelationshipsController < ApplicationController 
  load_and_authorize_resource :user
  
  def index
    @title = params[:action_type]
    @users = @user.send(params[:action_type]).page params[:page]
  end
end
