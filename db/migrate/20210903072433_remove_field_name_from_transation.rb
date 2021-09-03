class RemoveFieldNameFromTransation < ActiveRecord::Migration[6.1]
  def up
    remove_column :transactions, :transfer_id, :integer
  end
end
