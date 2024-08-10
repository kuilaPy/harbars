class CreateRefunds < ActiveRecord::Migration[7.1]
  def change
    create_table :refunds do |t|
      t.string :raz_refund_id
      t.string :status
      t.integer :payment_id
      t.integer :order_id
      t.float :amount

      t.timestamps
    end
  end
end
