class ChangeColumnType < ActiveRecord::Migration[6.1]
  def change
    # change_column :transactions, :category, :integer
    change_column :transactions, :category, 'integer USING CAST(category AS integer)'

  end
end
