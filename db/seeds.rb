# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# :name, :email, :password, :password_confirmation, :provider, :uid

# Create some test players
(1..6).each do |i|
  u = User.new(
    :name => "Player - #{i}",
    :email => "player+#{i}@example.com",
    :password => '1234',
    :password_confirmation => '1234',
  )

  u.save!(:validate => false)
end

