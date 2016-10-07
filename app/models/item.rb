class Item < ActiveRecord::Base
	belongs_to :user
	has_many :rentals

	def index
		@item = Items.all 
	end

	def new
		@item = Item.new
	end

	def create
		item = Item.create(item_params)
	end

	def edit

	end

	def update
		
	end

	def destroy

	end		
	
private

	def item_params

		params.require(:item).permit(:name, :description, :user_id, {avatars[]})

	end
end

name
description
avatars
user_id


