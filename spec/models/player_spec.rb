require 'spec_helper'

describe Player do
  let(:player) { Fabricate(:player) }

  it 'has a valid factory for players' do
    expect(player).to be_valid
  end
end
