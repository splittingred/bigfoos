class Team < ActiveRecord::Base
  has_many :players
  has_many :users, :through => :players
  belongs_to :game

  accepts_nested_attributes_for :players
end
