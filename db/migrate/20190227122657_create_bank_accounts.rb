class CreateBankAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_accounts do |t|
      t.string :ifsc
      t.float :balance, default: 0
      t.boolean :is_primary, default: false
      t.references :user
      t.timestamps
    end
  end
end
