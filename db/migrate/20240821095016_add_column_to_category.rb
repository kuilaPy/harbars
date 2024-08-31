class AddColumnToCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :parent_category_id, :integer
  end
end
