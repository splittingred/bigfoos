require 'spec_helper'

describe User do
  let!(:user) { create :user }

  it 'has a valid factory for players' do
    expect(user).to be_valid
  end

  it 'test ordered_by_score scope' do
    4.times { create(:user,score: rand(500)) }

    users = User.ordered_by_score
    last_score = 99999999999
    users.each do |u|
      expect(u.score).to be < last_score
    end
  end

  it 'test of_ids scope' do
    ids = []
    4.times { ids << create(:user).id }

    users = User.of_ids(ids)
    users.each do |u|
      expect(ids).to include u.id
      ids.delete(u.id)
    end
    expect(ids).to be_empty
  end

  it 'test games accessor' do
    expect(user.games.count).to eq 0

    m = create_game_for_user

    expect(user.games.count).to eq 1
    expect(user.games.first).to eq m[:game]
  end

  it 'test total_points' do
    expect(user.total_points).to eq 0

    p = create(:player,user: user)
    p.save
    p.score
    expect(user.total_points).to eq 1

    p = create(:player,user: user)
    p.save
    p.score
    expect(user.total_points).to eq 2
  end

  it 'test average points per game accessor' do
    expect(user.average_points_per_game.to_i).to eq 0

    m = create_game_for_user

    m[:player1].score

    expect(user.average_points_per_game).to eq 1

    p = create(:player,user: user)
    p.save
    p.score
    p.score

    expect(user.average_points_per_game).to eq 1.5
  end

  it 'test average points against per game' do
    expect(user.average_points_against_per_game.to_i).to eq 0

    m = create_game_for_user

    m[:player1].score
    m[:player3].score
    m[:player4].score
    m[:player4].score
    m[:player3].score
    m[:player4].score
    expect(m[:game].status).to eq 'finished'

    expect(user.average_points_against_per_game).to eq 5
  end

  it 'test points_for accessor' do
    m = create_game_for_user
    expect(user.points_for(m[:game])).to eq m[:player1].points
  end

  it 'test last scored at' do
    m = create_game_for_user
    s = m[:player1].score

    expect(user.last_scored_at).to eq s.created_at.to_s(:long)
  end

  context 'stats' do
    it 'test stats' do
      expect(user.stats.size).to eq 0
      user.inc_stat(:fake,3)
      expect(user.stats.size).to eq 1

      u2 = create(:user)
      u2.inc_stat(:fake,5)
      expect(user.stats.size).to eq 1
      s = user.stats.first
      expect(s.rank).to eq 2
      expect(s.name).to eq 'fake'
      expect(s.value).to eq 3
    end

    it 'test stat' do
      expect(user.stat(:game_changer)).to eq 0
      user.inc_stat(:game_changer)
      expect(user.stat(:game_changer)).to eq 1
    end

    it 'test stat returning object' do
      user.inc_stat(:hyper_growth)
      s = user.stat(:hyper_growth,false)
      expect(s).to be_a UserStat
      expect(s.value).to eq 1
      expect(s.name).to eq 'hyper_growth'
    end

    it 'test set stat' do
      user.set_stat(:foo,23)
      expect(user.stat(:foo)).to eq 23
    end

    it 'test delete stat' do
      user.inc_stat(:war_room,50)
      expect(user.stat(:war_room)).to eq 50
      user.delete_stat(:war_room)
      expect(user.stat(:war_room)).to eq 0
    end

    context 'incrementing stat' do
      it 'test inc stat' do
        expect(user.stat(:bar)).to eq 0
        user.inc_stat(:bar,23)
        expect(user.stat(:bar)).to eq 23
      end

      it 'test inc stat with increment > 1' do
        expect(user.stat(:bar2)).to eq 0
        user.inc_stat(:bar2,2)
        expect(user.stat(:bar2)).to eq 2
      end
    end

    context 'decrementing stat' do
      it 'test dec stat' do
        user.set_stat(:bar,10)
        expect(user.stat(:bar)).to eq 10
        user.dec_stat(:bar,2)
        expect(user.stat(:bar)).to eq 8
      end

      it 'test dec stat with decrement > 1' do
        user.set_stat(:bar2,23)
        expect(user.stat(:bar2)).to eq 23
        user.dec_stat(:bar2,2)
        expect(user.stat(:bar2)).to eq 21
      end
    end

    it 'test stats as hash' do
      user.set_stat(:foo,123)
      user.set_stat(:bar,23)
      hash = user.stats_as_hash
      expect(hash).to have_key(:foo)
      expect(hash[:foo]).to eq 123
      expect(hash).to have_key(:foo)
      expect(hash[:bar]).to eq 23
    end
  end

  it 'test recalculation of win/loss ratio' do
    user.set_stat(:wins,90)
    user.set_stat(:games,100)
    expect(user.recalculate_ratios).to be_truthy
    expect(user.ratio('win-loss',true)).to eq 0.9
  end

  it 'test recalculation of pf/pa ratio' do
    user.set_stat(:scores,30)
    user.set_stat(:scored_against,20)
    expect(user.recalculate_ratios).to be_truthy
    expect(user.ratio('pf-pa',true)).to eq 0.6
  end

  def create_game_for_user
    g = create(:game)
    t1 = create(:team,game: g,color: 'Yellow')
    p1 = create(:player,team: t1,user: user)
    p2 = create(:player,team: t1)
    t1.players << p1
    t1.players << p2
    g.teams << t1

    t2 = create(:team,game: g,color: 'Black')
    p3 = create(:player,team: t2)
    p4 = create(:player,team: t2)
    t2.players << p3
    t2.players << p4
    g.teams << t2
    g.save

    expect(g.teams.count).to eq 2
    expect(g.teams.first.other_team).to eq g.teams.last
    expect(p1.game).to eq g
    expect(p3.game).to eq g
    expect(p4.game).to eq g
    expect(user.players.first.game).to eq g

    {
        game: g,
        team1: t1,
        team2: t2,
        player1: p1,
        player2: p2,
        player3: p3,
        player4: p4
    }
  end
end
