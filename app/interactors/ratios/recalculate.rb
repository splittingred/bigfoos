module Ratios
  class Recalculate
    include Interactor::Organizer

    organize Ratios::Calculate::WinLoss,
             Ratios::Calculate::PointsForPointsAgainst
  end
end
