class Admin::BaseController < ApplicationController
  before_action :authenticate_admi_user!
  layout "admin"


end
