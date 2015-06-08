class Score < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  before_destroy :delete_score

  scope :for_player, ->(player) { where(player: player) }
  scope :for_player_and_game, ->(player,game) { where(player: player, game: game) }

  ##
  # Removes a score record, properly decrementing points and scores on appropriate tables
  #
  def delete_score
    transaction do
      self.player.points = self.player.points - 1
      if self.player.save
        self.player.team.score = self.player.team.score - 1
        self.player.team.save
      end
      self.player.dec_score_stats
    end
  end
end
