class Team < ActiveRecord::Base
  has_many :players, :dependent => :destroy
  has_many :users, :through => :players
  belongs_to :game

  accepts_nested_attributes_for :players, :allow_destroy => true

  def won?
    self.won
  end
end
