module Achievements
  class Grant
    include Interactor

    before do
      @user = context.user
      @game = context.game
      @achievement = context.achievement
    end

    def call
      context.fail!(error: 'Already has achievement!') if @user.has_achievement?(@achievement)

      UserAchievement.create!(user: @user, achievement: @achievement, game: @game)
      #RailgunMailer.achievement_gained(user: user,achievement: self).deliver
    rescue ActiveRecord::ActiveRecordError => e
      context.fail!(error: e.message)
    end
  end
end
