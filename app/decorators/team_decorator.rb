class TeamDecorator < ApplicationDecorator
  delegate_all
  decorates_association :players

  def css_class
    color.downcase
  end
end
