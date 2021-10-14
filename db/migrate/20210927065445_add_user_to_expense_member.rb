class AddUserToExpenseMember < ActiveRecord::Migration[6.1]
  def change
    add_reference :expense_members, :user, foreign_key: true
  end
end
