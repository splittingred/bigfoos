class Ratio < ActiveRecord::Base
  belongs_to :user

  scope :for_user,->(user,k) { where(user_id:user.id,name:k) }

  class << self
    def set_for_user(user,k,v)
      ratio = Ratio.for_user(user,k).first
      unless ratio
        ratio = Ratio.new
        ratio.user = user
        ratio.name = k
      end
      ratio.value = v
      ratio.save
    end

    def recalculate_for(user)
      stats = user.stats_as_hash
      return false unless stats

      # W/L
      ratio = (stats[:games].to_i > 0) ? (stats[:wins].to_f / stats[:games].to_f) : 0.00
      Ratio.set_for_user(user,'win-loss',ratio)

      # Points For / Points Against
      scores = stats[:scores].to_i
      tot_points = (scores + stats[:scored_against].to_i).to_i
      ratio = scores.to_f / tot_points.to_f
      Ratio.set_for_user(user,'pf-pa',ratio)
      true
    end
  end
end
