class GamesController < ApplicationController
  before_action :fetch_game, only: [:show, :edit, :update, :destroy]
  before_action :build_game, only: [:new, :create]
  before_action :prepare_teams, only: [:edit]

  def index
    @games = Game.finished.page(params[:page])
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
    render
  end

  def create
    data = game_params
    teams = data.delete(:teams_attributes)
    @game = Game.new(data)

    teams.each do |idx,t|
      if t[:players_attributes]
        users = t.delete(:players_attributes)
        team = Team.new(t)

        users.each do |user_id|
          player = Player.new
          player.user_id = user_id.to_i
          team.players << player
        end

        @game.teams << team
      end
    end if teams

    authorize! :create, @game
    @game.save ? redirect_to(@game, flash: { success: 'Game successfully created.'}) : render(action: :new)
  end

  def update
    authorize! :update, @game
    @game.update_attributes(game_params) ? redirect_to(@game, notice: 'Game successfully updated.') : render(action: :edit)
  end

  def destroy
    authorize! :destroy, @game
    @game.destroy
    redirect_to games_path
  end

  protected

  def fetch_game
    @game = Game.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Game not found'
    redirect_to :action => :index
  end

  def prepare_teams
    @players = {}
    yu = @game.users_for_team('Yellow')
    @players[:yellow] = yu ? yu.collect{ |u| u.id } : []
    bu = @game.users_for_team('Black')
    @players[:black] = bu ? bu.collect{ |u| u.id } : []
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
    params.require(:game).permit(:num_players,teams_attributes: [
      :id,
      :score,
      :color,
      :_destroy,
      :players_attributes => (@game.new_record? ? [] : [:id,:user_id,:points,:_destroy])
    ])
  end
end
