class ScoreWorker
  include SuckerPunch::Job

  def perform(game)
    ActiveRecord::Base.connection_pool.with_connection do
      User.score_all
      Achievement.recalculate(game.users,game)
    end
  end
end