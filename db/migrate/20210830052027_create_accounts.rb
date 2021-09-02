class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :accountnumber
      t.string :accountname
      t.string :accounttype
      t.integer :accountbalance

      t.timestamps
    end
  end
end
