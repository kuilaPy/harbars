class Admin::BaseController < ActionController::Base
  before_action :authenticate_admin_user!
  before_action :add_initial_breadcrumbs
  layout "admin"


  def add_initial_breadcrumbs
    breadcrumbs.add "Admin"
  end
end
