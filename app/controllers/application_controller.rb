class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?

  protected

	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    		user_params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :country, :location, :formatted_address, :route, :postal_code, :locality, :administrative_area_level_1)
		end
	end
end


# registration_params = [:first_name, :last_name, :email, :password, :password_confirmation, :country, :location, :formatted_address, :route, :postal_code, :locality, :administrative_area_level_1]
