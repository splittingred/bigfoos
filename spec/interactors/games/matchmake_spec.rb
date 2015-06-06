require 'spec_helper'

describe Games::Matchmake do
  before do
    create_list :user, 4
  end

  let(:params) { { users: User.limit(4) } }
  let(:interactor) { described_class.new(params) }
  let(:context) { interactor.tap(&:run).context }


  describe '#call' do
    it 'should succeed and make a game' do
      expect(context).to be_a_success
      expect(context.game).to be_a(Game)
      expect(context.game.teams.count).to eq 2
      expect(context.game.teams.first.players.count).to eq 2
      expect(context.game.teams.last.players.count).to eq 2
      expect(context.game.teams.first).to_not eq context.game.teams.last
    end

  end
end
