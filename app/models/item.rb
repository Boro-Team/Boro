class Item < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader

	belongs_to :user
	has_many :rentals

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


