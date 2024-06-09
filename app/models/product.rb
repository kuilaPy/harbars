class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :reviews
  has_many :questions

  has_many_attached :product_images
  has_rich_text :specification

  validates :name, presence: true
end
