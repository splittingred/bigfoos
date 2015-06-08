module Players
  module Losing
    class UpdateStatus
      include Interactor

      before do
        @player = context.player
      end

      def call
        @player.update!(
          won: false,
          points_against: @player.other_team.score
        )
      rescue ActiveRecord::ActiveRecordError => e
        context.fail!(error: e.message)
      end

      def rollback
        @player.update!(
          won: nil,
          points_against: nil
        )
      end
    end
  end
end
