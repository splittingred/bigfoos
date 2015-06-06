class AchievementDecorator < ApplicationDecorator
  delegate_all

  decorates_association :users

  def stat_name
    stat.humanize
  end

  def show_link
    h.link_to name, h.achievement_path(self)
  end

  def criteria
    stat.capitalize+' '+operator+' '+value.to_s
  end

end
