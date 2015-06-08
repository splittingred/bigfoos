module Scores
  ##
  # Revert a score for a player
  #
  # @param [Interactor::Context<Player>] player
  # @return [Interactor::Context]
  #
  class Revert
    include Interactor::Organizer

    organize Scores::Reversion::DecreasePlayerPoints,
             Scores::Reversion::DecreaseTeamScore,
             Scores::Reversion::DecrementPlayerStats,
             Scores::Reversion::DestroyRecord
  end
end
