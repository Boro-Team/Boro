class Item < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	belongs_to :user
	has_many :rentals

		def disabledDates
	  i_id = self.id
  	rental = Rental.where("item_id = ?", i_id)
  	booked_days = []  	

  	rental.each do |r|
  		booked_array = *(r.start_date..r.end_date)  
			booked_days << booked_array 	 
		end
	  	booked_dates = []
	  	booked_days = booked_days.flatten
	  	booked_days.each do |b|
			booked_dates<<b.strftime("%d/%m/%Y")	  		
	  	end
	  	return booked_dates
	end

end



