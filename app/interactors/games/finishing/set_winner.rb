module Games
  module Finishing
    class SetWinner
      include Interactor

      before do
        @game = context.game
      end

      def call
        winning_team = @game.teams.where('score >= ?',5).first
        if winning_team.present?
          result = Teams::Win.call(team: winning_team)
          context.fail!(result.error) unless result.success?
        else
          context.fail!(error: 'Could not find winning team!')
        end
      end

      def rollback
        # oh hell
      end
    end
  end
end
