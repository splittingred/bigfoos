class Score < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  before_create :add_score
  before_destroy :delete_score

  def add_score
    transaction do
      self.player.points = self.player.points + 1
      if self.player.save
        self.player.team.score = self.player.team.score + 1
        self.player.team.save
      end
    end
  end

  def delete_score
    transaction do
      self.player.points = self.player.points - 1
      if self.player.save
        self.player.team.score = self.player.team.score - 1
        self.player.team.save
      end
    end
  end
end
