class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :message
      t.string :msg_rf_id , null: false

      t.timestamps
    end
    add_index :contacts, :msg_rf_id, unique: true
  end
end
