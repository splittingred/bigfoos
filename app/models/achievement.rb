class Achievement < ActiveRecord::Base
  has_many :user_achievements
  has_one :next_achievement, :foreign_key => 'prior', :class_name => 'Achievement'

  scope :recent,->(limit = 20) {
    select('achievements.*,users.name,user_achievements.created_at')
      .joins('JOIN user_achievements ON achievements.id = user_achievements.achievement_id JOIN users ON users.id = user_achievements.user_id')
      .order('user_achievements.created_at DESC, achievements.stat ASC, achievements.value ASC')
      .limit(limit)
  }
  scope :with_code,->(code) { where(code: code).first }
  scope :paged,->(limit = 0,offset = 0) { limit(limit).offset(offset) }
  scope :for_user,->(user_id) {
    joins(:user_achievements)
    .select('achievements.*,user_achievements.created_at AS earned_on')
    .where(:user_achievements => {:user_id => user_id})
    .order('stat ASC, value ASC')
  }

  default_scope { order('stat ASC, value ASC')}

  class << self
    ##
    # Recalculate achievements for given users
    def recalculate(users,game = nil)
      granted = Hash.new
      users.each do |user|
        granted[user.name.to_sym] = [] unless granted[user.name.to_sym]

        stats = user.stats_as_hash
        achievements = user.achievements_as_list

        Achievement.all.each do |ach|
          if stats.key?(ach.stat.to_sym) and !achievements.include?(ach.code.to_s)
            value = ach.value.to_i
            op = ach.operator.to_sym
            if stats[ach.stat.to_sym].send(op,value)
              ach.grant(user,game)
              granted[user.name.to_sym] << ach.code
            end
          end
        end
      end
      granted
    end

    def grant(code,user,game = nil)
      achievement = Achievement.with_code(code)
      if achievement
        achievement.grant(user,game)
      end
    end
  end

  def to_param
    code
  end

  def grant(user,game = nil)
    return false unless UserAchievement.for_user_and_achievement(user,self).count == 0

    ua = UserAchievement.new
    ua.user = user
    ua.achievement = self
    ua.game = game unless game.nil?
    success = ua.save
    if success
      RailgunMailer.achievement_gained(user: user,achievement: self).deliver
    end
  end

  def users
    User
      .joins(:user_achievements)
      .joins("INNER JOIN user_stats ON users.id = user_stats.user_id AND user_stats.name = '"+self.stat+"'")
      .select('users.*,user_stats.value')
      .where(:user_achievements => {:achievement_id => self.id})
      .order('value DESC')
  end

  def users_close(limit = 20,offset = 0,range = 0.75)
    list = Hash.new
    op = self.operator.to_sym
    value = self.value.to_i
    proximity = value * range
    UserStat.select('user_stats.*,users.name AS user_name').joins(:user).where(:name => self.stat).order('user_stats.value DESC').limit(limit).offset(offset).each do |stat|
      if stat.value.to_i.send(op,proximity) and stat.value < value
        list[stat.user_name] = stat.value
      end
    end
    list
  end

  def users_as_list(limit = 20,offset = 0)
    l = {}
    l[:total] = self.users.joins("INNER JOIN user_stats ON users.id = user_stats.user_id AND user_stats.name = '"+self.stat+"'").count
    l[:results] = {}
    l[:offset] = offset

    self.users.select('users.*,user_stats.value')
    .joins("INNER JOIN user_stats ON users.id = user_stats.user_id AND user_stats.name = '"+self.stat+"'")
    .limit(limit).offset(offset)
    .order('user_stats.value DESC').each do |u|
      l[:results][u.name] = u.value
    end
    l
  end

  def related(limit = 10,offset = 0)
    tag = self.code.split('.').first.split('-').first
    list = []
    Achievement.where('code LIKE ? AND id != ?','%'+tag+'%',self.id).order('stat ASC, value ASC').limit(limit).offset(offset).each do |a|
      list << {
          :code => a.code,
          :name => a.name,
          :description => a.description
      }
    end
    list
  end

  def prior_achievement
    Achievement.where(:id => self.prior).first
  end

  def trajectory(list = [])
    current = self
    limit = 0
    until (prior = current.prior_achievement).nil? or limit > 10
      list << prior.attributes
      current = prior
      limit += 1
    end
    list.reverse!
    list << self.attributes.merge({:current => true})
    current = self
    limit = 0
    until (na = current.next_achievement).nil? or limit > 10
      list << na.attributes
      current = na
      limit += 1
    end
    list
  end
end
