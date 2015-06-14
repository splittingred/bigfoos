module Ratios
  module Calculate
    class PointsForPointsAgainst
      include Interactor

      before do
        @user = context.subject
      end

      def call
        stats = @user.stats_as_hash
        context.fail!(error: 'Could not get stats for user') unless stats.present?

        scores = stats[:scores].to_i
        total_points = (scores + stats[:scored_against].to_i).to_i
        ratio = total_points > 0 ? scores.to_f / total_points.to_f : 0.00
        Ratios::Set.call(user: @user, name: 'pf-pa', value: ratio)
      end
    end
  end
end

