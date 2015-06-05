class Api::V1::UsersController < Api::ApiController

  def index
    @users = filter_users
    render json: @users, serializer: Api::V1::PaginationSerializer, each_serializer: Api::V1::UserSerializer
  end

  protected

  def filter_users
    apply_scopes(User.order(:created_at).page(params[:page]))
  end

end
