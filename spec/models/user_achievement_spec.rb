require 'spec_helper'

describe UserAchievement do
  let!(:user) { create :user }
  let!(:achievement) { create :achievement }
  let!(:user_achievement) { create :user_achievement, user: user, achievement: achievement }

  it 'test for_user_and_achievement scope' do
    ua = UserAchievement.for_user_and_achievement(user,achievement)
    expect(ua.count).to eq 1
  end
end
