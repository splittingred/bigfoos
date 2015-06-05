class Api::V1::GamesController < Api::ApiController

  def index
    @games = filter_games
    render json: @games, serializer: Api::V1::PaginationSerializer, each_serializer: Api::V1::GameSerializer
  end

  protected

  def filter_games
    apply_scopes(Game.order(:created_at).page(params[:page]))
  end

end
