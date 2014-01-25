require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user) }

  it 'has a valid factory for players' do
    expect(user).to be_valid
  end

  it 'test ordered_by_score scope' do
    4.times { Fabricate(:user,score: rand(500)) }

    users = User.ordered_by_score
    last_score = 99999999999
    users.each do |u|
      expect(u.score).to be < last_score
    end
  end

  it 'test of_ids scope' do
    ids = []
    4.times { ids << Fabricate(:user).id }

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

    p = Fabricate(:player,user: user)
    p.save
    p.score
    expect(user.total_points).to eq 1

    p = Fabricate(:player,user: user)
    p.save
    p.score
    expect(user.total_points).to eq 2
  end

  it 'test average points per game accessor' do
    expect(user.average_points_per_game.to_i).to eq 0

    m = create_game_for_user

    m[:player1].score

    expect(user.average_points_per_game).to eq 1

    p = Fabricate(:player,user: user)
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

  def create_game_for_user
    g = Fabricate(:game)
    t1 = Fabricate(:team,game: g,color: 'Yellow')
    p1 = Fabricate(:player,team: t1,user: user)
    p2 = Fabricate(:player,team: t1)
    t1.players << p1
    t1.players << p2
    g.teams << t1

    t2 = Fabricate(:team,game: g,color: 'Black')
    p3 = Fabricate(:player,team: t2)
    p4 = Fabricate(:player,team: t2)
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
