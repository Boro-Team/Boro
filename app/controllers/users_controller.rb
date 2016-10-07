class UsersController < ApplicationController
	
	def index
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

