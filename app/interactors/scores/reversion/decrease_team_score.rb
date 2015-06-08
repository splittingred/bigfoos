module Scores
  module Reversion
    ##
    # Decrease the team score
    #
    # @param [Interactor::Context<Player>] player
    # @return [Interactor::Context]
    #
    class DecreaseTeamScore
      include Interactor

      before do
        @player = context.player
        @team = @player.team
      end

      def call
        @team.update!(score: @team.score - 1)

      rescue ActiveRecord::ActiveRecordError => e
        context.fail!(error: e.message)
      end

      def rollback
        @team.update!(score: @team.score + 1)
      end
    end
  end
end
