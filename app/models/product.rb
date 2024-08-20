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
  validates :original_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :approx_delivery_cost, presence: true,  numericality: { greater_than_or_equal_to: 0 }
  validates :discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }


  after_save :update_price 

  scope :by_search,     lambda { |search| where('name ILIKE ?', "%#{search.downcase}%")}
  scope :by_category,   lambda { |category_id| where(category_id: category_id) }
  scope :by_review,     lambda { |review| left_joins(:reviews).group('products.id').having('AVG(reviews.rating) > ?', review) }


  def self.popular_product
    left_joins(:reviews).group('products.id').order('COUNT(reviews.id) DESC')
  end


  def update_price
    price = (original_price * (1 - discount / 100))
    update_columns(price: price)
  end

  def product_ratings
    reviews&.average(:rating)&.round(1) || 0
  end

  def review_count 
    reviews.count
  end

  def avarage_rating
    reviews&.average(:rating)&.round(1) || 0
  end

end
