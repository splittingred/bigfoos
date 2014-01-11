class Player < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :user

  class << self
    def for_user(game,user)
      team_ids = game.teams.pluck(:id)
      Player.where(team_id: team_ids, user_id: user.id).first
    end
  end

  def top_scorer?
    team_ids = self.team.game.teams.pluck(:id)
    Player.where(:team_id => team_ids).maximum(:points) == self.points
  end
end
