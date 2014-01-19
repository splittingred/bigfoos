class UsersController < ApplicationController
  before_action :fetch_user, only: [:show, :edit, :update, :destroy]
  before_action :build_user, only: [:new]

  def index
    @users = User
      .select('users.*, (SELECT COUNT(*) FROM players WHERE players.user_id = users.id AND players.won = true) AS wins, (SELECT COUNT(*) FROM players WHERE players.user_id = users.id AND players.won = false) AS losses')
      .order('name ASC').page(params[:page])
  end

  def show
    render
  end

  def new
    render
  end

  def edit
    render
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

  def fetch_user
    @user = User.find(params[:id])
  end

  def build_user
    @user = User.new
  end

  def user_params
    params.require(:user).permit(:name, :email, :uid)
  end
end
