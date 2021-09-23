class AddTransferToInTransactions < ActiveRecord::Migration[6.1]
  def change
    add_reference  :transactions, :transfer_to,polymorphic:true
    add_reference :transactions, :transfer_from,polymorphic:true
  end
end
