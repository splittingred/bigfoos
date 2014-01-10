require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user) }

  it 'has a valid factory for players' do
    expect(user).to be_valid
  end
end
