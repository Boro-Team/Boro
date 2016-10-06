# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random-location'
require 'faker'

# User
for u in (1..30)
	User.create(:name => Faker::Name.name, :email => Faker::Internet.free_email, :password => "1234", :address => RandomLocation.near_by(3.139474, 101.636964, 10000), :avatars => ["image-#{u}"], :admin => false)
end

# Item
for i in (1..30)
	Item.create(:title => Faker::Hipster.sentence(3), :description => Faker::Hipster.paragraph, :avatars => ["item#{i}"], :price_per_day => (1..10).sample, :user_id => i)
end

# Rental

# start_date
# end_date
# user_id
# item_id
# total_price


