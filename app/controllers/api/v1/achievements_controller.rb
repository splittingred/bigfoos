class Api::V1::AchievementsController < Api::ApiController

  def index
    @achievements = filter_achievements
    render json: @achievements, serializer: Api::V1::PaginationSerializer, each_serializer: Api::V1::AchievementSerializer
  end

  protected

  def filter_achievements
    apply_scopes(Achievement.order(:created_at).page(params[:page]))
  end

end
