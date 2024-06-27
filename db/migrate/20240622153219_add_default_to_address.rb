class AddDefaultToAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :is_default, :boolean
    add_column :addresses, :name, :string 
    add_column :addresses, :contact_number, :string
    change_column :addresses, :address_type, :integer, using: 'address_type::integer'
  end
end
