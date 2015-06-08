module Scores
  module Creation
    ##
    # Increase player points
    #
    # @param [Interactor::Context<Player>] player
    # @return [Interactor::Context]
    #
    class IncreasePlayerPoints
      include Interactor

      before do
        @player = context.player
      end

      def call
        @player.update!(points: @player.points + 1)

      rescue ActiveRecord::ActiveRecordError => e
        context.fail!(error: e.message)
      end

      def rollback
        @player.update!(points: @player.points - 1)
      end
    end
  end
end
