class Game < ActiveRecord::Base
  has_many :teams
  has_many :players
  has_many :users, :through => :players

  def users_for_team(color)
    self.teams.where(color: color).first.users
  end
end
