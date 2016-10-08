class ItemsController < ApplicationController
before_action :set_item, only: [:show, :update, :edit, :destroy]
  
  def index
  	@item = Item.all
    if signed_in?
      items_per_page = 10  
      params[:page] = 1 unless params[:page] 
      first_item ||= (params[:page].to_i - 1) * items_per_page
      items = Item.all 
      @nb_pages_needed = items.count / items_per_page
      if params[:tag]
        @item = Item.tagged_with(params[:tag])
      else    
        @items = items[first_item...(first_item + items_per_page)]
      end
    else
      flash[:notice] = "Please Log In or Sign Up"
      redirect_to root_path
    end
  end

  # def search
  #       @items = item.search(params[:term], fields: ["title", "location","description"], mispellings: {below: 5})
  #       if @items.blank?
  #         redirect_to items_path, flash:{danger: "no successful search result"}
  #       else
  #         render :index
  #       end
  # end  

  def new
    @item = Item.new
  end

  def create
    
    @item = current_user.items.new(item_params)  
      respond_to do |format|        
        if @item.save
          # I want to send an e-mail and then...
          # itemJob.perform_later(current_user.email, @item.id)
          # I want to go to my item show page
          format.html { redirect_to(@item, notice: "item was successfully created !")}
          format.json { render json: @item, status: :created, location: @item }
        else
          format.html { render action: 'new' }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit    
  	@item = Item.find(params[:id])
  end

  def update
  	@item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item #item_path(@item.id)
    else 
      redirect_to edit_item_path(@item.id)
    end    
  end  

  def destroy
    @item = Item.find(params[:id])
    ex_l = @item.id
   	@item.destroy
 	  redirect_to item_path, :notice => "item #{ex_l} deleted"
  end

  private

  def item_params
  	params.require(:item).permit(:title, :description, :price_per_day, :user_id, :avatar)
  end

  def set_item
    @item = Item.find(params[:id]) 
  end  
end
