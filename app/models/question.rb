class Question < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :replies
end
