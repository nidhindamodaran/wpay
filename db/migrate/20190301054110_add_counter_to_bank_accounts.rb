class AddCounterToBankAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :bank_accounts, :wpay_transactions_count, :integer
  end
end
