class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :bank_account
      t.float :amount
      t.string :recipient_id
      t.integer :transaction_type

      t.timestamps
    end
  end
end
