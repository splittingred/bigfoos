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
        @user = @player.user
        @other_team = @player.other_team
      end

      def call
        @user.inc_stat(:scores)
        @user.inc_stat(:score_as_front) if @player.position == 'front'
        @user.inc_stat(:score_as_back) if @player.position == 'back'

        @other_team.players.each do |p|
          p.user.inc_stat(:scored_against)
          p.user.inc_stat(:scored_against_as_front) if p.position == 'front'
          p.user.inc_stat(:scored_against_as_back) if p.position == 'back'
        end if @other_team.present?

      rescue ActiveRecord::ActiveRecordError => e
        context.fail!(error: e.message)
      end

      def rollback
        @player.dec_score_stats
      end
    end
  end
end
