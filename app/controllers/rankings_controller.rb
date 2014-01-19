class RankingsController < ApplicationController

  def index
    @users = User.where('score > ?',0).order('score DESC').page
  end

  protected
end
