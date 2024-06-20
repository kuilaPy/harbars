class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  def self.rating_percentage
    rating_counts = group(:rating).count
    total_count = count

    rating_percentages = rating_counts.transform_values do |count|
      (count.to_f / total_count * 100).round(2)
    end
    rating_percentages.sort.to_h
  end
end
