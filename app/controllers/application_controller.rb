class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :mailbox, :conversation
  
  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end
  
  protected

	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    		user_params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :country, :location, :formatted_address, :route, :postal_code, :locality, :administrative_area_level_1, :avatar, :avatar_cache)
		end
		devise_parameter_sanitizer.permit(:account_update) do |user_params|
    		user_params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :country, :location, :formatted_address, :route, :postal_code, :locality, :administrative_area_level_1, :avatar, :avatar_cache)
		end
	end
end


# registration_params = [:first_name, :last_name, :email, :password, :password_confirmation, :country, :location, :formatted_address, :route, :postal_code, :locality, :administrative_area_level_1]
