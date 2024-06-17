class AddExternalId < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :external_user_id, :string
    add_column :carts, :external_user_id, :string
    add_index :users, :external_user_id
    remove_column :carts, :user_id
    add_column :carts, :user_id, :integer
  end
end
