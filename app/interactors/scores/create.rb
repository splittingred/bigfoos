module Scores
  ##
  # Score a point for a given player
  #
  # @param [Interactor::Context<Player>] player
  # @return [Interactor::Context]
  #
  class Create
    include Interactor::Organizer

    organize Scores::Creation::PersistRecord,
             Scores::Creation::IncreasePlayerPoints,
             Scores::Creation::IncreaseTeamScore,
             Scores::Creation::IncrementPlayerStats,
             Scores::Creation::CheckForGameEnd
  end
end
