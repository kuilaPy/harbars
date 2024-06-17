class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  attr_accessor :external_user_id
end
