module Scores
  module Creation
    ##
    # Check for the game end
    #
    # @param [Interactor::Context<Player>] player
    # @return [Interactor::Context]
    #
    class CheckForGameEnd
      include Interactor

      before do
        @player = context.player
        @team = @player.team
        @game = @player.game
      end

      def call
        if @team.score >= 5
          result = Games::Finish.call(game: @game)
          context.fail!(error: result.error) unless result.success?
        end
      end
    end
  end
end
