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
    @item = current_user.items.new(item_params)  
      respond_to do |format|        
        if @item.save
          format.html { redirect_to(@item, notice: "item was successfully created !")}
          format.json { render json: @item, status: :created, location: @item }
        else
          format.html { render action: 'new' }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
	end

	def edit

	end

	def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else 
      redirect_to edit_item_path(@item.id)
    end     		
	end

	def destroy
		@item = Item.find(@item.user_id)		
	end		
	
private

	def item_params

		params.require(:item).permit(:name, :description, :user_id, {avatars[]})

	end
end



