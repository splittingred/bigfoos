module Games
  module Finishing
    class ScheduleScoreWorker
      include Interactor

      before do
        @game = context.game
      end

      def call
        ScoreWorker.new.async.perform(@game)
      end
    end
  end
end
