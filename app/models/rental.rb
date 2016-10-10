class Rental < ActiveRecord::Base
	belongs_to :item

	validates :start_date, presence: true
	validates :end_date, presence: true
	
	validate :date_is_valid?, :item_is_available?

	# def disabledDates
	#   i_id = self.item_id
 #  	rental = Rental.where("item_id = ?", i_id)
 #  	booked_days = []  	

 #  	rental.each do |r|
 #  		booked_array = *(r.start_date..r.end_date)  
	# 		booked_days << booked_array 	 
	# 	end
	  	
	#   	booked_days = booked_days.flatten 
	# end

  
	def date_is_valid?
    if start_date.present? && start_date < Date.today
      @errors.add(:start_date,"can't be in the past")
    	return false   
    end

		sd = start_date.to_datetime
		ed = end_date.to_datetime
		nd = Time.now	

		if (sd < ed)    
			return true 
		else
			@errors.add(:end_date, "cannot be before starting date.")
			return false
		end 
	end

  def item_is_available?
	  i_id = self.item_id
  	rental = Rental.where("item_id = ?", i_id)
  	desired_array = *(self.start_date..self.end_date)
  	booked_days = []  	

  	rental.each do |r|
  		booked_array = *(r.start_date..r.end_date)  
			intersection =  (booked_array & desired_array)
			booked_days << intersection 	 
		end
	  if booked_days.flatten.empty?
	  	return true
  	else
	    # self.errors.add(:start_date, "Not available at these dates. Please change your rental dates.")
	    self.errors.add(:base, booked_days.flatten)  
		end
	end

end
