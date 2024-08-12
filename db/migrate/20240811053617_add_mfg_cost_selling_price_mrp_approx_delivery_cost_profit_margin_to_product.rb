class AddMfgCostSellingPriceMrpApproxDeliveryCostProfitMarginToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :mfg_cost, :decimal
    add_column :products, :approx_delivery_cost, :decimal
  end
end
