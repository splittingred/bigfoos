module Games
  module Finishing
    class SetLoser
      include Interactor

      before do
        @game = context.game
      end

      def call
        losing_team = @game.teams.where('score < ?',5).first
        if losing_team.present?
          result = Teams::Lose.call(team: losing_team)
          context.fail!(result.error) unless result.success?
        else
          context.fail!(error: 'Could not find losing team!')
        end
      end

      def rollback
        # oh hell
      end
    end
  end
end
