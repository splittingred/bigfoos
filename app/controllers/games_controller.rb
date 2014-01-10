class GamesController < ApplicationController
  before_action :fetch_game, only: [:show, :edit, :update, :destroy]
  before_action :build_game, only: [:new]

  def index
    @games = Game.all
  end

  def show
    render
  end

  def new
    @users = User.all
    render
  end

  def edit
    @users = User.all
    @yellow_team_users = @game.users_for_team('Yellow').collect{ |u| u.id }
    @black_team_users = @game.users_for_team('Black').collect{ |u| u.id }
    render
  end

  def update
    authorize! :update, @game
    @game.update_attributes(game_params) ? redirect_to(@game, notice: 'Game successfully updated.') : render(action: :edit)
  end

  def destroy

  end

  protected

  def fetch_game
    @game = Game.find(params[:id])
  end

  def build_game
    @game = Game.new
    @game.teams = []
    ['Yellow','Black'].each do |c|
      t = Team.new
      t.color = c
      t.num_players = 2
      @game.teams << t
    end
  end

  def game_params
    params.require(:game).permit(:num_players)
  end
end
