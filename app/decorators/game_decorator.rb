class GameDecorator < ApplicationDecorator
  delegate_all

  decorates_association :teams

  def show_link
    h.link_to (l(created_at, format: :long)), h.game_path(self)
  end
end
