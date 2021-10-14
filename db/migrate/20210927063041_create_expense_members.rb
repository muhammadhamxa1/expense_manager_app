class CreateExpenseMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_members do |t|
      t.references :group_expense,foreign_key:{to_table: :group_expenses}
      t.float :borrow
      t.float :lent
      t.references :lenter, null: true,foreign_key:{to_table: :users}
      t.references :borror, null: true,foreign_key:{to_table: :users}

      t.timestamps
    end
  end
end
