namespace :bigfoos do
  namespace :achievement do
    task :ensure => :environment do
      ActiveRecord::Base.logger = nil
      Achievement.recalculate(User.all)
    end

    task :clear => :environment do
      ActiveRecord::Base.logger = nil
      UserAchievement.all.each do |a|
        a.destroy
      end
    end
  end
end