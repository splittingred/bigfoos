require 'spec_helper'

describe Team do
  let(:team) { create :team }

  it 'test won?' do
    team.won = false
    expect(team.won?).to be_falsey
    team.won = true
    expect(team.won?).to be_truthy
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
