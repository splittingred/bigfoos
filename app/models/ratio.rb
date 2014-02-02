class Ratio < ActiveRecord::Base
  belongs_to :user

  scope :for_user,->(user,k) { where(user_id:user.id,name:k).first }

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
  end
end
