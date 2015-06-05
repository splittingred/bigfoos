class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :score,
             :created_at,
             :updated_at
end
