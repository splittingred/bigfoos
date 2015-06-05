class Api::V1::GameSerializer < ActiveModel::Serializer
  attributes :id,
             :status,
             :num_players,
             :num_teams,
             :created_at,
             :updated_at,
             :ended_at
end
