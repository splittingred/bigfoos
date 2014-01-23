namespace :bigfoos do
  namespace :achievement do
    task :ensure => :environment do
      ActiveRecord::Base.logger = nil
      Achievement.recalculate(User.all)
    end
  end
end