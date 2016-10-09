class ItemsController < ApplicationController
before_action :set_item, only: [:update, :edit, :destroy]
  
  def index
    @index_page = true 
  	@item = Item.all
    if signed_in?
      items_per_page = 10  
      params[:page] = 1 unless params[:page] 
      first_item ||= (params[:page].to_i - 1) * items_per_page


    if params[:formatted_address] == "" or params[:formatted_address]==nil
      items=Item.all
    else
      items=[]
      
      if params[:range].to_i>0
        users=User.near(params[:formatted_address], params[:range])
      else
        if params[:postal_code] == ""
          if params[:locality] == ""
            if params[:administrative_area_level_1] == ""
                users=User.where(country: params[:country])
            else
              users=User.where(administrative_area_level_1: params[:administrative_area_level_1])
            end
          else
            users=User.where(locality: params[:locality])
          end
        else
          users=User.where(postal_code: params[:postal_code])
        end
      end

      if users==[] or users==nil
        users=User.all
        @no_user_error = "No items found in your search area. All locations displayed"
      end

      # params[:range] = "20" unless (params[:range].to_i>0)
      # users=User.near(params[:formatted_address], params[:range])
      users.each do |u|
        items<<u.items
      end
      items.flatten!
    end

      @nb_pages_needed = items.count / items_per_page
      if params[:tag]
        @item=[]
        items.each do |i|
          @item<<i if i.tag_list.include?(params[:tag])
        end
      else    
        @item = items[first_item...(first_item + items_per_page)]
      end


      @hash = Gmaps4rails.build_markers(@item) do |item, marker|
          marker.lat item.user.latitude
          marker.lng item.user.longitude
          marker.json({:id => item.id })
          marker.json({:title => item.title })
          marker.infowindow item.search_card
          marker.picture({
           "url" => "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png",
           "width" =>  32,
           "height" => 32})
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
 	  redirect_to items_path, :notice => "item #{ex_l} deleted"
  end


  def tag
    @tagged = Item.tagged_with(params[:tag_id])
    @tag = params[:tag_id]
  end

# 1. In the terminal, run 'elasticsearch'
# 2. In a separate tab in the terminal, run 'rake searchkick:reindex CLASS=Item'
  def search  
    @index_page = false 
    @item = Item.search(params[:term], fields: ["title", "description"], mispellings: {below: 5})
    if @item.blank?
      redirect_to items_path, flash:{danger: "no successful search result"}
    else
      render :index
    end
  end

  private

  def item_params
  	params.require(:item).permit(:title, :description, :price_per_day, :user_id, :avatar, :tag_list)
  end

  def set_item
    @item = Item.find(params[:id]) 
  end  
end
