class Score < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  scope :for_player, ->(player) { where(player: player) }
  scope :for_player_and_game, ->(player,game) { where(player: player, game: game) }
end
