class TeamDecorator < ApplicationDecorator
  delegate_all
  decorates_associations :players, :users

  def css_class
    color.downcase
  end
end
