class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders, id: :string do |t|
      t.references :user, null: false, foreign_key: true
      t.float :total_price
      t.string :status

      t.timestamps
    end
  end
end
