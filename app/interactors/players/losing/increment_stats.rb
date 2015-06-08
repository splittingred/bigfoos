module Players
  module Losing
    class IncrementStats
      include Interactor

      before do
        @player = context.player
      end

      def call
        @player.user.inc_stat(('played_'+@player.position.name).to_sym)
        @player.user.inc_stat(:losses)
        @player.user.inc_stat(:games)

      rescue StandardError => e
        context.fail!(error: e.message)
      end

      def rollback
        @player.user.dec_stat(('played_'+@player.position.name).to_sym)
        @player.user.dec_stat(:losses)
        @player.user.dec_stat(:games)
      end
    end
  end
end
