class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  decorates_assigned :user, :users
  decorates_assigned :game, :games
  decorates_assigned :achievement, :achievements

  def index
    @users = filter_users
  end

  def show
    @games = @user.games.latest.page(params[:page])
    @achievements = @user.achievements.page(params[:page])
    @stats = @user.stats_as_hash
  end

  def new
    @user = User.new
  end

  def update
    authorize! :update, @user
    @user.update_attributes(user_params) ? redirect_to(@user, notice: 'User successfully updated.') : render(action: :edit)
  end

  def destroy
    authorize! :destroy, @user
    @user.destroy
    redirect_to users_path
  end

  protected

  def filter_users
    User
        .select('users.*, (SELECT COUNT(*) FROM players WHERE players.user_id = users.id AND players.won = true) AS wins, (SELECT COUNT(*) FROM players WHERE players.user_id = users.id AND players.won = false) AS losses')
        .order('name ASC').page(params[:page])
  end

  def load_user
    @user = User.find(params[:id])
  rescue => e
    not_found('feature_set', e)
  end

  def user_params
    params.require(:user).permit(:name, :email, :uid)
  end
end
