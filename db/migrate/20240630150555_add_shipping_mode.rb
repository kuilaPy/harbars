class AddShippingMode < ActiveRecord::Migration[7.1]
  def up
    remove_column :payments, :order_id
    add_column :payments, :razorpay_order_id, :string
    add_column :payments, :payment_reference, :string
    add_column :payments, :user_id, :integer
    add_column :payments, :remarks, :string
    add_column :payments, :cart_id, :integer
    add_column :orders, :payment_id, :integer
    add_column :orders, :shipping_mode, :integer
    add_column :orders, :order_reference, :string
    add_column :orders, :total_with_gst, :decimal
    add_column :orders, :delivery_cost, :decimal
    change_column :orders, :status, :integer, using: 'status::integer', default: 1
    change_column :payments, :status, :integer, using: 'status::integer', default: 1
    change_column :payments, :payment_method, :integer, using: 'payment_method::integer'
  end

  def down
    add_column :payments, :order_id, :integer
    remove_column :payments, :razorpay_order_id
    remove_column :payments, :payment_reference
    remove_column :payments, :remarks
    remove_column :payments, :cart_id
    remove_column :orders, :payment_id, :integer
    remove_column :payments, :user_id
    remove_column :orders, :shipping_mode
    remove_column :orders, :order_reference
    remove_column :orders, :total_with_gst
    remove_column :orders, :delivery_cost
    change_column :orders, :status, :string
    change_column :payments, :status, :string
    change_column :payments, :payment_method, :string
  end
end
