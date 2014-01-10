class Player < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :user

  def top_scorer?
    self.game.players.maximum(:points) == self.points
  end
end
