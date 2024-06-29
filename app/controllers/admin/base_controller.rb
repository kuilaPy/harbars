class Admin::BaseController < ActionController::Base
  before_action :authenticate_admin_user!
  before_action :add_breadcrumbs
  layout "admin"


  def add_breadcrumbs
    breadcrumbs.add "Admin"
  end
end
