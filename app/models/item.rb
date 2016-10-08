class Item < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader

	belongs_to :user
	has_many :rentals

	acts_as_taggable # Alias for acts_as_taggable_on :tags
end



