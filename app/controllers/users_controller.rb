class UsersController < ApplicationController
	
	def index
    # @users = User.all
    
    if params[:formatted_address] == "" or params[:formatted_address]==nil
      byebug
      @users=User.all
    else
      params[:range] = "20" unless (params[:range].to_i>0)
      @users=User.near(params[:formatted_address], params[:range]) 
      byebug
    end
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
        marker.json({:id => user.id })
        marker.json({:title => user.first_name })
        marker.infowindow user.email
        marker.picture({
         "url" => "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png",
         "width" =>  32,
         "height" => 32})
    end
	end

	def edit
		@user = current_user
	end

  def update
  	@user = current_user
  	if @user.update(user_params)
  	session[:msg] = nil
  	redirect_to root_path
  	else
  	session[:msg] = @user.errors.full_messages
  	redirect_to edit_user_path(current_user.id)
		end
	end 


  private
  	def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :formatted_address, :location, :route, :postal_code, :locality, :administrative_area_level_1, :country, :admin)
    end

end

