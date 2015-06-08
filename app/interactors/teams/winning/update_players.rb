module Teams
  module Winning
    class UpdatePlayers
      include Interactor

      before do
        @team = context.team
      end

      def call
        @team.players.each do |player|
          Players::Win.call(player: player)
        end
      end
    end
  end
end
