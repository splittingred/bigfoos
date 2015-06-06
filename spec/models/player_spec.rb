require 'spec_helper'

describe Player do
  let(:player) { create :player }

  it 'test game accessor' do
    game = player.team.game
    expect(player.game).to eq game
  end

  context 'scoring' do
    it 'test score' do
      score = player.score
      expect(score.player).to eq player
      expect(score.game).to eq player.game
      expect(player.points).to eq 1
      expect(player.team.score).to eq 1
    end

    it 'test unscore' do
      player.score
      expect(player.points).to eq 1
      expect(player.team.score).to eq 1
      expect(player.unscore).to_not eq false
      player.reload
      expect(player.points).to eq 0
      expect(player.team.score).to eq 0
    end

    it 'test failed unscore' do
      expect(player.unscore).to be_falsey
      expect(player.points).to eq 0
    end
  end


  it 'test top_scorer?' do
    player.score
    expect(player.top_scorer?).to be_truthy

    player2 = Player.new
    player2.team = player.team
    player2.points = 2
    player2.save

    expect(player.top_scorer?).to be_falsey
    expect(player2.top_scorer?).to be_truthy
  end

  it 'test team_color' do
    expect(player.team_color).to eq player.team.color.downcase
  end

  it 'test other teams color' do
    expect(player.other_teams_color).to eq (player.team.color.downcase == 'yellow' ? 'black' : 'yellow')
  end

  it 'test other_team' do
    team2 = Team.new
    team2.game = player.team.game
    team2.save

    expect(player.other_team).to_not eq player.team
    expect(player.other_team).to eq team2
  end
end
