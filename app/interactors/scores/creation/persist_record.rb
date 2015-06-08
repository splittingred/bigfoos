module Scores
  module Creation
    ##
    # Persist score record
    #
    # @param [Interactor::Context<Player>] player
    # @return [Interactor::Context]
    #
    class PersistRecord
      include Interactor

      before do
        @player = context.player
      end

      def call
        @score = Score.create!(game: @player.game, player: @player)
      rescue ActiveRecord::ActiveRecordError => e
        context.fail!(error: e.message)
      end

      def rollback
        @score.destroy! if @score.present?
      end
    end
  end
end
