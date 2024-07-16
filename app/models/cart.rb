class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items
  has_many :products, through: :cart_items
  has_one :payment

  def total_saved
    self.cart_items.joins(:product).sum('products.original_price * cart_items.quantity') - self.total_price
  end
end
