class UserAchievement < ActiveRecord::Base
  belongs_to :achievement
  belongs_to :user
  belongs_to :game

  scope :for_user_and_achievement,->(user,achievement) {
    where(user: user,achievement: achievement)
  }
end
