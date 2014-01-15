class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :omniauthable,
         :omniauth_providers => [:google_oauth2]

  has_many :players, :dependent => :destroy
  has_many :teams, :through => :players

  scope :top_scorers, -> { joins(:players).select('users.*,SUM(players.points) AS points').group('users.id').order('points DESC') }
  scope :top_points_per_game, -> { joins(:players).select('users.*,AVG(players.points) AS points').group('users.id').order('points DESC') }
  scope :most_games, -> { joins(:players).select('users.*,COUNT(players.id) AS games').group('users.id').order('games DESC') }
  scope :top_winners, -> { joins(:players).select('users.*,COUNT(players.won) AS wins').group('users.id').order('wins DESC')}

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

  def self.from_omniauth(auth)
    user = User.find_by_email(auth.info.email)
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider || 'google_oauth2'
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email
      end
    end
  end
end
