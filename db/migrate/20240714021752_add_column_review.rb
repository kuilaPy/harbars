class AddColumnReview < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :order_id, :integer
  end
end
