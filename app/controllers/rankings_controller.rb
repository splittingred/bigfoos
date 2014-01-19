class RankingsController < ApplicationController

  def index
    @users = User.order('score DESC').all
  end

  protected
end
