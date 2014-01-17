namespace :bigfoos do
  desc 'Cleanup any orphaned records'
  task :cleanup => :environment do
    Team.select('teams.*').joins('left join games g on teams.game_id = g.id').where('g.id is null').each do |t|
      t.destroy
    end
  end

  task :fix_games_stat => :environment do
    Player.all.each do |p|
      p.user.set_stat(:games,p.user.players.count)
    end
  end
end