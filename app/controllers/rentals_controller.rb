class RentalsController < ApplicationController
# This is a fast way to require someting before. See set_item method in private folder.	
	before_action :set_rental, only: [:update, :edit] # :destroy

	def index 
    @items = Item.all
  end	

	def new
		@item = Item.find(params[:item_id])
		@rental = Rental.new
	end

  def create
    @item = Item.find(params[:item_id])    
    @rental = @item.rentals.new(rental_params) 
    @rental.user_id = current_user.id 
    @rental.total_price = (@rental.end_date - @rental.start_date) * @item.price_per_day

    # @host = "andry.developper@gmail.com"
    # if @rental.valid?
    #    @rental.approval_status = true 
    # end
    # @rental.save unless (@rental.approval_status === false)
    # @host = "andry.developper@gmail.com" #LATER User.find(@item.user_id).email

    # if @rental.save
    # flash[:notice] = "Thank you for booking with BarBnB"      
    # render 'confirmation'

    # #RentalMailer.notification_email(current_user.email, @host, @rental.item.id, @rental.id).deliver_later
    # # RentalMailer to send a notification email after save
    # #RentalJob.perform_now("andry.developper@gmail.com", "andry.developper@gmail.com", 1, 1) FOR TESTING
    # RentalJob.perform_later(current_user.email, @host, @rental.item.id, @rental.id)
    # # call out rental job to perform the mail sending task after @rental is successfully saved     
    # else 
    #   flash[:error] = @rental.errors
    #   redirect_to new_item_rental_path(@item.id)
    # end

    if @rental.valid? && @rental.save
      @rental.update(approval_status: true)
      flash[:notice] = "Enjoy your Boro stuff ;D"  
      render 'confirmation'
    else
      flash[:error] = @rental.errors
      redirect_to new_item_rental_path(@item.id)
    end


  end

  def show
    # @user = Rental.where("user_id = ?", current_user.id)
    # @rental = Rental.find(params[:id])
    # @item = Item.find(@rental.item_id)   
    @item = Item.all 
    render 'index'
  end

#   def destroy
#     @item = Item.find(@rental.item_id)
#     @rental = Rental.find(params[:id])
#     ex_r = @rental.id

#     respond_to do |format|
#       format.html { redirect_to item_path(@item)}
#       format.js 
#     @rental.destroy
#     redirect_to item_path(@item.id), :notice => "Rental #{ex_r} cancelled"
#     end

#   end

private
  def rental_params
    params[:rental][:start_date] = Date.parse(params[:rental][:start_date].to_s)
    params[:rental][:end_date] = Date.parse(params[:rental][:end_date].to_s )
    params.require(:rental).permit(:start_date, :end_date, :total_price, :price_per_day, :item_id, :user_id, :approval_status) 
  end

  def set_rental
    @rental = Rental.find(params[:item_id])
  end
end




