class Game < ActiveRecord::Base
  has_many :teams
  has_many :players
  has_many :users, :through => :players

  accepts_nested_attributes_for :teams

  def users_for_team(color)
    team = self.teams.where(color: color).first
    team ? team.users : nil
  end

  def score_as_string
    str = []
    self.teams.each do |t|
      str << t.score.to_s
    end
    str.join ' / '
  end

  def winning_team
    self.teams.order('score DESC').first
  end
end
