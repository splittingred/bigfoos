class GamesController < ApplicationController
  before_action :fetch_game, only: [:show, :edit, :update, :destroy]
  before_action :build_game, only: [:new, :create, :auto, :auto_create]
  before_action :prepare_teams, only: [:edit]

  decorates_assigned :games, :game

  def index
    @games = filter_games
  end

  def show
    render :in_progress if @game.in_progress?
  end

  def new
    @users = User.order('name ASC')
  end

  def auto
    @users = User.order('name ASC')
  end

  def auto_create
    result = Games::Matchmake.call(user_ids: game_params[:auto_users], random_teams: game_params[:random_teams])

    if result.success?
      flash[:success] = 'Game successfully created.'
      redirect_to result.game
    else
      flash.now[:error] = result.error
      @users = User.order('name ASC')
      render action: :auto
    end
  end

  def edit
    @users = User.order('name ASC')
  end

  def score
    @player = Player.find(params[:player_id])

    result = Scores::Create.call!(player: @player)

    render nothing: true unless result.success?
  end

  def unscore
    @player = Player.find(params[:player_id])
    @player.unscore
  rescue ActiveRecord::RecordNotFound
    render nothing: true
  rescue ActiveRecord::RecordNotSaved
    render nothing: true
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

  def filter_games
    Game.latest.page(params[:page])
  end

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
                                 :random_teams,
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
