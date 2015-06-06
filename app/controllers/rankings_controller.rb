class RankingsController < ApplicationController

  decorates_assigned :users, :user

  def index
    @users = filter_users
  end

  protected

  def filter_users
    User.select('users.*,AVG(players.points) AS ppg,AVG(players.points_against) AS ppg_against')
        .joins(:players)
        .where('score > ?',0)
        .group('users.id')
        .order('score DESC').page
  end
end
