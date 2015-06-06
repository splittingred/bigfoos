class Game < ActiveRecord::Base
  has_many :teams, :dependent => :destroy
  has_many :users, :through => :players
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
  def users_for_team(color)
    team = team_by_color(color)
    team ? team.users : nil
  end

  def team_by_color(color)
    self.teams.where(color: color).first
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
  # Finishes the game, setting winners/losers
  #
  def finish
    saved = false
    transaction do
      winner = self.teams.where('score >= ?',5).first
      loser = self.teams.where('score < ?',5).first
      if winner and loser
        winner.win
        loser.lose
        self.status = 'finished'
        self.ended_at = Time.now
        saved = self.save

        ScoreWorker.new.async.perform(self)
      end
    end
    saved
  end

  ##
  # Sets winner for the game
  #
  def set_winner(team)
    if team.win
      self.status = 'finished'
      self.save
    end
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
