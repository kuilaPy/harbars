class Order < ApplicationRecord
  enum shipping_mode: {cod: 1, online: 2}
  enum status: {initiate: 1, payment: 2, shipped: 3, delivered: 4, returned: 5}

  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :payment, optional: true
  belongs_to :user
  belongs_to :shipping_address, class_name: "Address", foreign_key: "shipping_address_id"
  belongs_to :billing_address, class_name: "Address", foreign_key: "billing_address_id"

  before_validation :set_order_reference

  def get_expect_delivery_date
    self.reload
  end

  private 

  def set_order_reference
    return if order_reference.present?
    begin
      self.order_reference = _key = generate_key
    end while self.class.exists?(order_reference: _key)
  end

  def generate_key
    SecureRandom.hex[0...16]
  end
  
end
