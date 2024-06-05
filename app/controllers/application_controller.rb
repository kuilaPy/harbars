class ApplicationController < ActionController::Base
  # before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.is_a?(admin)
      admin_root_path
    else
      root_path
    end
  end
end
