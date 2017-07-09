class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string  :name
      t.string  :email
      t.string :mobile_number_1
      t.string :mobile_number_2
      t.string :mobile_number_3      
      t.timestamps
    end
  end
end
