class Question < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_one :reply
end
