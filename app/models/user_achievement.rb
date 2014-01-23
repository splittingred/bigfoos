class UserAchievement < ActiveRecord::Base
  belongs_to :achievements
  belongs_to :users
end
