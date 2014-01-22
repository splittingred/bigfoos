namespace :bigfoos do
  desc 'Cleanup any orphaned records'
  task :cleanup => :environment do
    Team.select('teams.*').joins('left join games g on teams.game_id = g.id').where('g.id is null').each do |t|
      t.destroy
    end
  end

  desc 'Fix games for users stat'
  task :fix_games_stat => :environment do
    Player.all.each do |p|
      p.user.set_stat(:games,p.user.players.count)
    end
  end

  desc 'Recalculate ratios for all users'
  task :recalculate_ratios => :environment do
    User.all.each do |u|
      u.recalculate_win_loss_ratio
      u.players.each do |p|
        p.points_against = p.other_team.score
        p.save
      end
    end
  end

  desc 'Fix score stats for all users'
  task :fix_score_stats => :environment do
    ActiveRecord::Base.logger = nil
    User.all.each do |u|
      u.set_stat(:scored_against,0)
      u.set_stat(:scores,0)
      u.set_stat(:score_as_front,0)
      u.set_stat(:score_as_back,0)
      u.set_stat(:scored_against_as_front,0)
      u.set_stat(:scored_against_as_back,0)
    end

    Game.all.each do |game|
      game.teams.each do |team|
        team.players.each do |p|
          p.points.times do
            p.inc_score_stats
          end
        end
      end
    end
  end
end