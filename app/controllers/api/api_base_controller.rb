class Api::ApiBaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_user!
end
