class Team < ActiveRecord::Base
  has_many :players, :dependent => :destroy
  has_many :users, :through => :players
  belongs_to :game

  accepts_nested_attributes_for :players, :allow_destroy => true

  ##
  # Alias for won
  #
  def won?
    self.won
  end

  ##
  # Set the team to win, updating players with win status
  #
  def win
    transaction do
      self.won = true
      if self.save
        self.players.each do |p|
          p.win
        end
      end
    end
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
end
