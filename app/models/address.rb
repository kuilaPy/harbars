class Address < ApplicationRecord
  belongs_to :user
  has_many :shipping_orders, class_name: "Order", foreign_key: "shipping_address_id"
  has_many :billing_orders, class_name: "Order", foreign_key: "billing_address_id"
end
