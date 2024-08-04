class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout -> {
    if turbo_frame_request?
      "turbo_rails/frame"
    else
      "application"
    end
  }
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :external_user_id])
  end
end
