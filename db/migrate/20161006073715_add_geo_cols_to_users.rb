class AddGeoColsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :formatted_address, :string 	#This is complete address 
  	add_column :users, :location, :string 
  	add_column :users, :route, :string							#street		
  	add_column :users, :postal_code, :string				#postcode		
  	add_column :users, :locality, :string						#suburb/city	
  	add_column :users, :administrative_area_level_1, :string				#State
    add_column :users, :latitude, :float            #latitude
    add_column :users, :longitude, :float				    #longitude
  end
end
