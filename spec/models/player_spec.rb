require 'spec_helper'

describe Player do
  let(:player) { create :player }

  it 'test game accessor' do
    game = player.team.game
    expect(player.game).to eq game
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
