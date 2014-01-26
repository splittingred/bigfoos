class UserStat < ActiveRecord::Base
  belongs_to :user

  scope :stats,-> { group(:name).pluck(:name) }
end
