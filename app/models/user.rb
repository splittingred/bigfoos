class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable#, :omniauthable

  has_many :players
  has_many :teams, :through => :players

  def total_points
    self.players.sum(:points)
  end

  def games
    game_ids = self.teams.pluck(:game_id)
    Game.where(:id => game_ids).all
  end

  def average_points_per_game
    self.players.average(:points)
  end

  def points_for(game)
    Player.for_user(game,self).points
  end

end
