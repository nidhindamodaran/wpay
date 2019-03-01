class CreateScratchCards < ActiveRecord::Migration[5.2]
  def change
    create_table :scratch_cards do |t|
      t.references :user
      t.references :wpay_transaction
      t.float :amount
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
