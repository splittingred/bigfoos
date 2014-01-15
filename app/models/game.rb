class Game < ActiveRecord::Base
  has_many :teams, :dependent => :destroy
  has_many :players, :dependent => :destroy
  has_many :users, :through => :players

  accepts_nested_attributes_for :teams, :allow_destroy => true

  scope :in_progress, -> { where(status: 'active') }
  scope :finished, -> { where(status: 'finished') }


  def users_for_team(color)
    team = self.teams.where(color: color).first
    team ? team.users : nil
  end

  def in_progress?
    self.status == 'active'
  end

  def score_as_string
    str = []
    self.teams.each do |t|
      str << t.score.to_s
    end
    str.join ' / '
  end

  def set_winner(team)
    self.transaction do
      team.won = true
      if team.save
        team.players.each do |p|
          p.won = true
          p.save
        end
        self.status = 'finished'
        self.save
      end
    end
  end

  def winning_team
    self.teams.order('score DESC').first
  end
end
