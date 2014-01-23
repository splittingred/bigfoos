class AchievementsController < ApplicationController

  before_action :fetch_achievement, only: [:show]

  def index
    @achievements = Achievement.page(params[:page])
  end

  def show

  end

  protected

  def fetch_achievement
    @achievement = Achievement.find_by_code(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Achievement not found'
    redirect_to :action => :index
  end
end
