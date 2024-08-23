class AddProfitToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :profit, :float
  end
end
