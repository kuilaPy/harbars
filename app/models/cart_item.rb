class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  attr_accessor :external_user_id

  after_save :update_cart_price
  after_destroy :update_cart_price

  def update_cart_price
    total_price = self.cart.cart_items.joins(:product).sum('products.price * cart_items.quantity')
    self.cart.update(total_price: total_price)
  end
end
