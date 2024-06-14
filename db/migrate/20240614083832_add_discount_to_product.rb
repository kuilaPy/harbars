class AddDiscountToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :discount, :float, default: 0
    add_column :products, :original_price, :float
  end
end
