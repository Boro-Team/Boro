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

# User
for u in (1..30)
	firstname = Faker::Name.first_name
	lastname  = Faker::Name.last_name
	name 			= firstname + " " + lastname 
	email 		= firstname + "." + lastname + "@boro.com"
	latitude 	= RandomLocation.near_by(3.134857, 101.629915, 10000)[0]
	longitude = RandomLocation.near_by(3.134857, 101.629915, 10000)[1]

	User.create(:first_name => firstname , :last_name => lastname, :email => Faker::Internet.free_email, :password => "123456", :latitude => latitude, :longitude => longitude, :avatar => "image-#{u}.thumb.url", :admin => false)
end

# Item
for i in (1..30)
	toTen = *(1..10)
	Item.create(:title => items[i], :description => Faker::Hipster.sentences(1)[0], :avatar => "item#{i}", :price_per_day => toTen.sample, :user_id => i)
end

# Rental
for r in (1..30)
	buffer = *(1..60)
	startdate = Date.today + buffer.sample # in the 2 next months
	enddate = startdate + [1,2,3].sample # duration 0f up to 3 days
	duration = enddate - startdate
	ppd = Item.find(r).price_per_day
	tot = ppd * duration

	Rental.create(:start_date => startdate, 
								:end_date 	=> enddate, 
								:approval_status => true, 
								:item_id => r, 
								:user_id => (-r), 
								:total_price => tot )
end


