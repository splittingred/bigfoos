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
end
