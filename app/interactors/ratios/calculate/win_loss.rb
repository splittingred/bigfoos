module Ratios
  module Calculate
    class WinLoss
      include Interactor

      before do
        @user = context.subject
      end

      def call
        stats = @user.stats_as_hash
        context.fail!(error: 'Could not get stats for user') unless stats.present?

        ratio = (stats[:games].to_i > 0) ? (stats[:wins].to_f / stats[:games].to_f) : 0.00
        Ratio.set_for_user(user,'win-loss',ratio)
      end
    end
  end
end

