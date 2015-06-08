module Players
  class Lose
    include Interactor::Organizer

    organize Players::Losing::UpdateStatus,
             Players::Losing::IncrementStats,
             Players::RecalculateRatios
  end
end
