class CreateFundTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :fund_transfers do |t|
      t.integer   :user_id
      t.integer   :contact_id
      t.string    :to_other
      t.decimal   :amount,    precision: 10, scale: 2
      t.string    :asset_type
      t.date      :transaction_date
      t.string    :transaction_number
      t.timestamps
    end
    add_index :fund_transfers, [:user_id, :transaction_date],  name: 'by_u_id_t_date'    
  end
end
