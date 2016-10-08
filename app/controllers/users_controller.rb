class UsersController < ApplicationController
	
	def index
    # @users = User.all
    

    if params[:location]
      @users=User.near(params[:location], params[:range])  
    else
      @users=User.all
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

