class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.integer :transaction_amount
      t.string :transfer_for
      t.integer :transfer_id
      t.string :category
      t.string :transfer_from

      t.timestamps
    end
  end
end
