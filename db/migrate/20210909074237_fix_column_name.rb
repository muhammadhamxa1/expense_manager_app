class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :transactions, :transfer_for, :transfer_to
  end

end

