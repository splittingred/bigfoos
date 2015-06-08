module Games
  class Finish
    include Interactor::Organizer

    organize Games::Finishing::SetWinner,
             Games::Finishing::SetLoser,
             Games::Finishing::UpdateStatus,
             Games::Finishing::ScheduleScoreWorker
  end
end
