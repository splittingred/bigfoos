require 'spec_helper'

describe Team do
  let(:team) { Fabricate(:team) }

  it 'has a valid factory for teams' do
    expect(team).to be_valid
  end

  it 'test won?' do
    team.won = false
    expect(team.won?).to be_false
    team.won = true
    expect(team.won?).to be_true
  end

  it 'test other_team' do
    team2 = Team.new
    team2.game_id = team.game_id
    team2.color = team.color == 'Yellow' ? 'Black' : 'Yellow'
    team2.num_players = 2
    team2.save

    expect(team.other_team).to eq team2
  end


end
