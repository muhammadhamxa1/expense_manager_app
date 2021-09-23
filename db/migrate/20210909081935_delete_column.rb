class DeleteColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :transfer_to, :string
    remove_column :transactions, :transfer_from, :string
  end
end
