module Achievements
  class RecalculateForUser
    include Interactor

    def call
      stats = user.stats_as_hash
      achievements = user.achievements_as_list

      Achievement.all.each do |ach|
        if stats.key?(ach.stat.to_sym) && !achievements.include?(ach.code.to_s)
          value = ach.value.to_i
          op = ach.operator.to_sym
          if stats[ach.stat.to_sym].send(op,value)
            Achievements::Grant.call(user: user, game: game, achievement: ach)
          end
        end
      end
    end
  end
end
