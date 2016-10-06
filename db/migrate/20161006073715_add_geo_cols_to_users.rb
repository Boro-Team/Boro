class AddGeoColsToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :address
  	remove_column :users, :state, :string
  	add_column :users, :location, :string 					#This is latitude&longitude together
  	add_column :users, :formatted_address, :string 	#This is complete address 
  	add_column :users, :route, :string							#street		
  	add_column :users, :postal_code, :string				#postcode		
  	add_column :users, :locality, :string						#suburb/city	
  	add_column :users, :administrative_area_level_1, :string				#State					
  end
end
