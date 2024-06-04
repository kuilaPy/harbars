class HomeController < ApplicationController
  layout 'public'
  def index
    render 'new_index'
  end
end
