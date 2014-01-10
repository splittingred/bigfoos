require 'spec_helper'

describe Game do
  let(:game) { Fabricate(:game) }

  it 'has a valid factory for team games' do
    expect(game).to be_valid
  end
end
