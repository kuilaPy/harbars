class AddDimensionAddWeigthShippedAtToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :length, :integer
    add_column :orders, :width, :integer
    add_column :orders, :height, :integer
    add_column :orders, :weight, :integer
    add_column :orders, :shipped_at, :datetime
    add_column :orders, :processed_at, :datetime
    add_column :orders, :delivered_at, :datetime
  end
end
