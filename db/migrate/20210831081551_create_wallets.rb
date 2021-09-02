class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.integer :walletbalance, default: 0, null: false

      t.timestamps
    end
  end
end
