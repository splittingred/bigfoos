namespace :bigfoos do
  desc 'Cleanup any orphaned records'
  task :cleanup => :environment do
    Team.select('teams.*').joins('left join games g on teams.game_id = g.id').where('g.id is null').each do |t|
      t.destroy
    end
  end
end