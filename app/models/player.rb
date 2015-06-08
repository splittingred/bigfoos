class Player < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :score, dependent: :destroy

  scope :by_team, ->(team) { where(team: team) }
  scope :by_user, ->(user) { where(user: user) }
  scope :top_scorer_for_teams, ->(team_ids) { where(team_id: team_ids).maximum(:points) }
  default_scope { order(:position_id) }

  class << self
    def for_user(game,user)
      team_ids = game.teams.pluck(:id)
      Player.where(team_id: team_ids, user_id: user.id).first
    end
  end

  def game
    self.team.game
  end

  def times_at_position(position)
    Player.where(user_id: self.user_id, position_id: position.to_s).count
  end

  def least_played_position
    f = times_at_position(:front)
    b = times_at_position(:back)
    f > b ? :back : :front
  end

  ##
  # Tells if this player is the top scorer for the game
  #
  def top_scorer?
    team_ids = self.team.game.teams.pluck(:id)
    Player.top_scorer_for_teams(team_ids) == self.points
  end

  ##
  # Get the players team color
  #
  def team_color
    self.team.color
  end

  ##
  # Get the other team's color
  #
  def other_teams_color
    self.team_color.yellow? ? Color.find(:black) : Color.find(:yellow)
  end

  ##
  # Get the opposing team of the player
  #
  def other_team
    self.team.other_team
  end

  def dec_score_stats
    self.user.dec_stat(:scores)
    self.other_team.players.each do |p|
      p.user.dec_stat(:scored_against)
      p.user.dec_stat(:scored_against_as_front) if p.position.front?
      p.user.dec_stat(:scored_against_as_back) if p.position.back?
    end if self.other_team
  end

  def position
    Position.find(position_id)
  end
end
