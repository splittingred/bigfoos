require 'spec_helper'

describe Achievement do
  before do
    @achievement = Fabricate(:achievement)
    @user = Fabricate(:user)
    @game = Fabricate(:game)
    @user_stat = Fabricate(:user_stat,user: @user,name: @achievement.stat,value: @achievement.value)
  end

  context 'scopes' do
    before do
      Fabricate(:user_achievement,achievement: @achievement,user: @user,game: @game)
    end
    it :recent do
      a = Achievement.recent(1)
      expect(a.count).to eq 1
      expect(a.first).to_not be_nil
      expect(a.first).to be_a(Achievement)
      expect(a.first.id).to eq @achievement.id
    end
  end

  it 'test grant with game' do
    @achievement.grant(@user,@game)
    expect(@achievement.user_achievements.count).to eq 1
    expect(@achievement.user_achievements.first.game_id).to eq @game.id
    expect(ActionMailer::Base.deliveries.last.to).to eq [@user.email]
    expect(ActionMailer::Base.deliveries.last.body).to_not be_empty

    @achievement.grant(@user,@game)
    expect(@achievement.user_achievements.count).to eq 1
  end

  it 'test grant class method' do
    expect(Achievement.grant(@achievement.code,@user)).to be_true
    expect(@user.achievements.count).to eq 1
    expect(@achievement.users.count).to eq 1
    expect(ActionMailer::Base.deliveries.last.to).to eq [@user.email]
    expect(ActionMailer::Base.deliveries.last.body).to_not be_empty
  end

  it 'test users as list' do
    @achievement.grant(@user)

    hash = @achievement.users_as_list(1,0)
    expect(hash).to_not be_nil
    expect(hash[:results].count).to eq 1
    expect(hash[:results]).to have_key(@user.name)
    expect(hash[:results][@user.name]).to eq @user_stat.value
    expect(hash[:offset]).to eq 0
    expect(hash[:total]).to eq 1
  end
end
