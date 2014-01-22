class RankingsController < ApplicationController

  def index
    @users = User.select('users.*,AVG(players.points) AS ppg,AVG(players.points_against) AS ppg_against')
                 .joins(:players)
                 .where('score > ?',0)
                 .group('users.id')
                 .order('score DESC').page
  end

  protected
end
