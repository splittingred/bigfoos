require 'spec_helper'

describe Team do
  let(:team) { Fabricate(:team) }

  it 'has a valid factory for teams' do
    expect(team).to be_valid
  end
end
