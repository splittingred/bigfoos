class Game < ActiveRecord::Base
  has_many :teams, dependent: :destroy
  has_many :users, through: :players
  has_many :scores

  accepts_nested_attributes_for :teams, :allow_destroy => true

  scope :in_progress, -> { where(status: 'active') }
  scope :finished, -> { where(status: 'finished') }
  scope :latest, -> { order(created_at: :desc) }

  attr_accessor :auto_users
  attr_accessor :random_teams

  ##
  # Returns a collection of User records for team of specified color
  #
  def users_for_team(color_id)
    team = team_by_color(color_id)
    team ? team.users : nil
  end

  def team_by_color(color_id)
    self.teams.where(color_id: color_id).first
  end

  ##
  # Returns true if game is in progress
  #
  def in_progress?
    self.status == 'active'
  end

  ##
  # Returns true if game is finished
  #
  def finished?
    self.status == 'finished'
  end

  ##
  # Returns score as string
  #
  def score_as_string(delimiter = ' /')
    str = []
    self.teams.each do |t|
      str << t.score.to_s
    end
    str.join delimiter
  end

  ##
  # Finds the winning team for the game by score
  #
  def winning_team
    self.teams.ordered_by_score.first
  end

  ##
  # Get all users in game
  #
  def users
    User.in_teams(self.teams.pluck(:id))
  end
end
