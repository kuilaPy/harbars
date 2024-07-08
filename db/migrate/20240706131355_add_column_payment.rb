class AddColumnPayment < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :razorpay_payment_id, :string
    add_column :payments, :razorpay_signature, :string
    add_column :payments, :captured_at, :datetime
    add_column :carts, :status, :boolean, default: true
    add_column :orders, :expected_delivery_date, :datetime
  end
end
