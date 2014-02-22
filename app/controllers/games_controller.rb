class GamesController < ApplicationController
  before_action :fetch_game, only: [:show, :edit, :update, :destroy]
  before_action :build_game, only: [:new, :create, :auto]
  before_action :prepare_teams, only: [:edit]

  def index
    @games = Game.order('created_at DESC').page(params[:page])
  end

  def show
    if @game.in_progress?
      @players = []

      @game.teams.each do | team |
        team.players.each do | player |
          @players << player
        end
      end

      if params[:feature] == 'foosui'
        @foosui = true
      end

      render :in_progress
    else
      render
    end
  end

  def new
    @users = User.order('name ASC')
    render
  end

  def auto
    @users = User.order('name ASC')
    render
  end

  def auto_create
    @game = Game.matchmake(game_params[:auto_users])
    authorize! :create, @game
    @game.save ? redirect_to(@game, flash: { success: 'Game successfully created.'}) : render(action: :auto)
  end

  def edit
    @users = User.order('name ASC')
  end

  def score
    @player = Player.find(params[:player_id])
    @player.score params[:scored_with]
  rescue ActiveRecord::RecordNotFound
    render :nothing => true
  end

  def unscore
    @player = Player.find(params[:player_id])
    @player.unscore
  rescue ActiveRecord::RecordNotFound
    render :nothing => true
  end

  def create
    @game = Game.new(game_params)
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
      2.times do
        t.players << Player.new
      end
      @game.teams << t
    end
  end

  def game_params
    params.require(:game).permit(:num_players,
                                 :auto_users => [],
                                 teams_attributes: [
      :id,
      :score,
      :color,
      :_destroy,
      :players_attributes => [
          :id,
          :user_id,
          :position,
          :points,
          :_destroy,
      ]
    ])
  end
end
