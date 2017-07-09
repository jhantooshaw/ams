class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :addressable_id
      t.string  :addressable_type
      t.string  :address
      t.string  :city
      t.string  :state
      t.string  :country
      t.integer :pin
      t.string  :other_info
      t.boolean :is_current, deafult: false
      t.timestamps
    end
    add_index :addresses, [:addressable_type, :addressable_id]
  end
end
