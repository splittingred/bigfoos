module Games
  module Finishing
    class UpdateStatus
      include Interactor

      before do
        @game = context.game
      end

      def call
        @game.update!(
          status: 'finished',
          ended_at: Time.now
        )
      rescue ActiveRecord::ActiveRecordError => e
        context.fail!(error: e.message)
      end

      def rollback
        @game.update!(
            status: 'active',
            ended_at: nil
        )
      end
    end
  end
end
