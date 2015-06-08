module Players
  class Win
    include Interactor::Organizer

    organize Players::Winning::UpdateStatus,
             Players::Winning::IncrementStats,
             Players::RecalculateRatios
  end
end
