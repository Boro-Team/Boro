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

# end
	acts_as_taggable # Alias for acts_as_taggable_on :tags
	searchkick match: :word_start, searchable: [:title, :description]

	def search_card
		if self.avatar.medium.url
			avatar=self.avatar.medium.url
			return '<a href="/items/'+self.id.to_s+'">'+self.title+' $'+self.price_per_day.to_s+'<img style="max-width: 50px; max-height: 50px"src='+avatar+'></a><br>'+self.description
		else
			return '<a href="/items/'+self.id.to_s+'">'+self.title+' $'+self.price_per_day.to_s+'</a><br>'+self.description
		end
	end

end


