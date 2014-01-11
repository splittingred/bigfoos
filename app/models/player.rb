class Player < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :user

  def top_scorer?
    team_ids = self.team.game.teams.pluck(:id)
    Player.where(:team_id => team_ids).maximum(:points) == self.points
  end
end
