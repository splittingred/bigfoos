module Players
  class RecalculateRatios
    include Interactor

    before do
      @player = context.player
    end

    def call
      @player.user.recalculate_ratios
    rescue StandardError => e
      context.fail!(error: e.message)
    end
  end
end
