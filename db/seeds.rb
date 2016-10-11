# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random-location'
require 'faker'

items = ["","sous vide", "sander", "projector", "PS4", "projector", "lawnmower", "toolbox", "fitness bench", "golf clubs", "fitness bicycle", "dumbbells", "treadmill", "diving suit", "skiing suit", "projector", "vacuum cleaner", "toolbox", "tool box", "drill", "mix table", "george foreman grill", "caravan", "trailer", "trailer", "mountain bike", "motorbike", "mountain bike", "cooking machine", "bread maker", "scuba diving equipment"]
firstname = Faker::Name.first_name
lastname  = Faker::Name.last_name
name 			= firstname + " " + lastname 
email 		= firstname + "." + lastname + "@boro.com"
latitude 	= RandomLocation.near_by(3.134857, 101.629915, 10000).latitude
longitude = RandomLocation.near_by(3.134857, 101.629915, 10000).longitude

# User
for u in (1..30)
	User.create(:name => Faker::Name.name, :email => Faker::Internet.free_email, :password => "123456", :latitude => latitude, :longitude => longitude, :avatars => ["image-#{u}"], :admin => false)
end

# Item
for i in (1..30)
	Item.create(:title => items[i], :description => Faker::Hipster.sentences(1)[0], :avatars => ["item#{i}"], :price_per_day => (1..10).sample, :user_id => i)
end

# Rental

# start_date
# end_date
# user_id
# item_id
# total_price


