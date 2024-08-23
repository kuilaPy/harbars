class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :child_categories, foreign_key: "parent_category_id", class_name: "Category"
  belongs_to :parent_category, foreign_key: "parent_category_id", class_name: "Category", optional: true

  validates :name, presence: true, uniqueness: true
end
