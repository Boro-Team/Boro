class Item < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	belongs_to :user
	has_many :rentals

end



