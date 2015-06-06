class PlayerDecorator < ApplicationDecorator
  delegate_all

  def top_scorer_css_class
    top_scorer? ? 'top-scorer' : ''
  end

  def position_formatted
    position.capitalize.to_s
  end

  def link_to_user
    h.link_to user.name, user
  end
end
