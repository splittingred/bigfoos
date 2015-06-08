class Team < ActiveRecord::Base
  has_many :players, dependent: :destroy
  has_many :users, through: :players
  belongs_to :game

  accepts_nested_attributes_for :players, allow_destroy: true

  scope :ordered_by_score, -> { order('score DESC') }

  def won?
    self.won
  end

  def lost?
    !won?
  end

  def other_team
    self.game.teams.where('color != ?',self.color).first
  end
end
