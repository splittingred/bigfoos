class Game < ActiveRecord::Base
  has_many :teams, :dependent => :destroy
  has_many :users, :through => :players
  has_many :scores

  accepts_nested_attributes_for :teams, :allow_destroy => true

  scope :in_progress, -> { where(status: 'active') }
  scope :finished, -> { where(status: 'finished') }

  attr_accessor :auto_users

  class << self
    def matchmake(user_ids)
      user_ids.reject!(&:empty?)
      return false if user_ids.count != 4

      # do something here to sort users by rank
      users = User.where(:id => user_ids).order('score DESC')

      game = Game.new
      game.num_players = 4
      game.teams = []

      player_order = [1,4,2,3]

      %w(Yellow Black).each_with_index do |c,cidx|
        positions = %w(front back)
        team = Team.new
        team.color = c
        team.num_players = 2
        2.times do
          player = Player.new
          # 1/4/2/3 selection of teams.
          player.user = users.at(player_order.shift.to_i-1)

          # randomly select position. Eventually make this based on player history
          player.position = positions.delete_at(rand(positions.length))

          team.players << player
        end
        game.teams << team
      end

      game
    end
  end

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

        User.score_all
        Achievement.recalculate(self.users,self.id)
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
    self.teams.order('score DESC').first
  end
end
