class HomeController < ApplicationController
  layout 'application'
  def index
    @contact = Contact.new
  end

  def privacy_policy
  end

  def terms_conditions
  end

  def shipping_policy
  end

  def return_policy
  end

  def cancellation_policy
  end
end
