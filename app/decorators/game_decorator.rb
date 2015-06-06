class GameDecorator < ApplicationDecorator
  delegate_all

  decorates_association :teams
end
