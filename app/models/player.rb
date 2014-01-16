class Player < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :score, :dependent => :destroy

  class << self
    def for_user(game,user)
      team_ids = game.teams.pluck(:id)
      Player.where(team_id: team_ids, user_id: user.id).first
    end
  end

  def score
    s = Score.new
    s.game = self.team.game
    s.player = self
    s.save
  end

  def unscore
    s = Score.where(:player_id => self.id, :game_id => self.team.game.id).first
    if s
      s.destroy
    else
      false
    end
  end

  def top_scorer?
    team_ids = self.team.game.teams.pluck(:id)
    Player.where(:team_id => team_ids).maximum(:points) == self.points
  end
end
