class Api::V1::AchievementSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :code,
             :description,
             :prior,
             :stat,
             :operator,
             :value,
             :created_at,
             :updated_at
end
