module Teams
  module Losing
    class UpdatePlayers
      include Interactor

      before do
        @team = context.team
      end

      def call
        @team.players.uniq.each do |player|
          Players::Lose.call(player: player)
        end
      end
    end
  end
end
