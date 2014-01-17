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

  ##
  # Gives a point to the player
  #
  def score
    s = Score.new
    s.game = self.team.game
    s.player = self
    s.save
  end

  ##
  # Takes away a point from the player
  #
  def unscore
    s = Score.where(:player_id => self.id, :game_id => self.team.game.id).first
    if s
      s.destroy
    else
      false
    end
  end

  ##
  # Sets the player to win the game
  #
  def win
    self.user.inc_stat(:wins)
    self.won = true
    self.finish
  end

  ##
  # Sets the player lose the game
  #
  def lose
    self.user.inc_stat(:losses)
    self.won = false
    self.finish
  end

  ##
  # finishes the game and stores a stat on position playing
  #
  def finish
    self.user.inc_stat(('played_'+self.position).to_sym)
    self.user.inc_stat(:games)
    self.user.recalculate_win_loss_ratio
    self.save
  end

  ##
  # Tells if this player is the top scorer for the game
  #
  def top_scorer?
    team_ids = self.team.game.teams.pluck(:id)
    Player.where(:team_id => team_ids).maximum(:points) == self.points
  end
end
