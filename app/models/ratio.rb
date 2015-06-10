class Ratio < ActiveRecord::Base
  belongs_to :user

  scope :for_user,->(user,k) { where(user: user, name: k) }
end
