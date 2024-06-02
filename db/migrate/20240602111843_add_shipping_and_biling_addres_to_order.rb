class AddShippingAndBilingAddresToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :shipping_address_id, :integer
    add_column :orders, :billing_address_id, :integer
  end
end
