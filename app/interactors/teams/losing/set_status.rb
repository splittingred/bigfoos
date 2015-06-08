module Teams
  module Losing
    class SetStatus
      include Interactor

      before do
        @team = context.team
      end

      def call
        @team.update!(won: false)

      rescue ActiveRecord::ActiveRecordError => e
        context.fail!(error: e)
      end

      def rollback
        @team.update!(won: nil)
      end
    end
  end
end
