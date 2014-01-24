require 'spec_helper'

describe UserAchievement do
  it 'test for_user_and_achievement scope' do
    user = Fabricate(:user)
    achievement = Fabricate(:achievement)
    Fabricate(:user_achievement,user: user,achievement: achievement)

    ua = UserAchievement.for_user_and_achievement(user,achievement)
    expect(ua.count).to eq 1
  end
end
