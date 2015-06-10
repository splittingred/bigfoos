module Players
  class RecalculateRatios
    include Interactor

    before do
      @player = context.player
    end

    def call
      result = Ratios::Recalculate.call(subject: @player.user)
      context.fail!(error: result.error) unless result.success?
    end
  end
end
