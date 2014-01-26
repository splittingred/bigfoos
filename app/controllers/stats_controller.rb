class StatsController < ApplicationController

  def index
    @top_scorers = User.top_scorers.limit(5)
    @top_winners = User.top_winners.limit(5)
    @top_losers = User.top_losers.limit(5)
    @top_ppg = User.top_points_per_game.limit(5)
    @most_games = User.most_games.limit(5)
    @best_wl_ratio = User.best_wl_ratio.limit(5)
    @stats = UserStat.stats
  end

  def show
    @stat = params[:id]
    @users = User.top_for_stat(@stat)
  end

  protected
end
