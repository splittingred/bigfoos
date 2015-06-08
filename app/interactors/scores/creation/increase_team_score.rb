module Scores
  module Creation
    ##
    # Score a point for a given player
    #
    # @param [Interactor::Context<Player>] player
    # @return [Interactor::Context]
    #
    class IncreaseTeamScore
      include Interactor

      before do
        @player = context.player
      end

      def call
        @player.team.update!(score: @player.team.score + 1)

      rescue ActiveRecord::ActiveRecordError => e
        context.fail!(error: e.message)
      end

      def rollback
        @player.team.update!(score: @player.team.score - 1)
      end
    end
  end
end
