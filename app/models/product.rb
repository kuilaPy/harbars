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

  after_save :update_price 

  def update_price
    price = (original_price * (1 - discount / 100))
    update_columns(price: price)
  end

  def product_ratings
    reviews&.average(:rating) || 0
  end

  def review_count 
    reviews.count
  end

end
