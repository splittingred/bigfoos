module Teams
  class Lose
    include Interactor::Organizer

    organize Teams::Losing::SetStatus,
             Teams::Losing::UpdatePlayers
  end
end
