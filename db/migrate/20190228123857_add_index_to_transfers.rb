class AddIndexToTransfers < ActiveRecord::Migration[5.2]
  def change
    add_index :wpay_transactions, :transaction_type
  end
end
