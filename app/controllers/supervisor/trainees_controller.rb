class Supervisor::TraineesController < ApplicationController
  before_action :require_supervisor

  def index
    @trainees = User.trainee.paginate page: params[:page],
      per_page: Settings.paginate.trainees
  end
end
