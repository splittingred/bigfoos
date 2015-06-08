class Team < ActiveRecord::Base
  has_many :players, :dependent => :destroy
  has_many :users, :through => :players
  belongs_to :game

  accepts_nested_attributes_for :players, :allow_destroy => true

  scope :ordered_by_score, -> { order('score DESC') }

  ##
  # Alias for won
  #
  def won?
    self.won
  end

  ##
  # Set the team to lose, updating players with loss status
  #
  def lose
    transaction do
      self.won = false
      if self.save
        self.players.each do |p|
          p.lose
        end
      end
    end
  end

  def other_team
    self.game.teams.where('color != ?',self.color).first
  end
end
