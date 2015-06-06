class AchievementsController < ApplicationController
  before_action :fetch_achievement, only: [:show]

  decorates_assigned :achievement, :achievements

  def index
    @achievements = filter_achievements
  end

  def show

  end

  protected

  def filter_achievements
    Achievement.page(params[:page])
  end

  def fetch_achievement
    @achievement = Achievement.find_by_code(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Achievement not found'
    redirect_to :action => :index
  end
end
