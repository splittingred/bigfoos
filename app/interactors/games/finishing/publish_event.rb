module Games
  module Finishing
    class PublishEvent
      include Interactor
      include Wisper::Publisher

      before do
        @game = context.game

        subscribe(NotifierObserver.new)
      end

      def call
        publish(:game_finished, game: @game)

      end
    end
  end
end
