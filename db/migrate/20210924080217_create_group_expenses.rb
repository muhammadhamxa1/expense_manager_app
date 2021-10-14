class CreateGroupExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :group_expenses do |t|
      t.string :expense_name
      t.integer :expense_amount
      t.belongs_to :group
      t.timestamps
    end
   
  end
end
