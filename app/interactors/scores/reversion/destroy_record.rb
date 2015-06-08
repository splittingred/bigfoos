module Scores
  module Reversion
    ##
    # Destroy score persistence record
    #
    # @param [Interactor::Context<Player>] player
    # @return [Interactor::Context]
    #
    class DestroyRecord
      include Interactor

      before do
        @player = context.player
      end

      def call
        @score = Score.for_player(@player).last
        if @score.present?
          @score.destroy!
        else
          context.fail!(error: 'No score found for given player!')
        end

      rescue ActiveRecord::ActiveRecordError => e
        context.fail!(error: e.message)
      end
    end
  end
end
