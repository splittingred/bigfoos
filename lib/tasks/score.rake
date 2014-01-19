namespace :bigfoos do
  namespace :score do
    task :all => :environment do
      ActiveRecord::Base.logger = nil
      User.all.each do |u|
        u.do_score
      end
    end
  end
end