module Scores
  module Creation
    ##
    # Increment the statistics for the given player.
    #
    # @TODO Eventually move this entirely out of the scoring flow. In reality, we should only be calculating statistics
    #       for finished matches. Move all this into the Scoring worker.
    #
    # @param [Interactor::Context<Player>] player
    # @return [Interactor::Context]
    #
    class IncrementPlayerStats
      include Interactor

      before do
        @player = context.player
      end

      def call
        @player.inc_score_stats

      rescue StandardError => e
        context.fail!(error: e.message)
      end

      def rollback
        @player.dec_score_stats
      end
    end
  end
end
