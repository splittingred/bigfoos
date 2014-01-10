class Ability
  include CanCan::Ability

  DOMAIN_WHITELIST = ['bigcommerce.com']

  def initialize(user)
    user ||= User.new
    
    can :read, :all
    can :manage, :all do
      user.email && (Rails.env.test? || DOMAIN_WHITELIST.include?(user.email.split('@')[1]))
    end
  end

end