class GroupExpense < ApplicationRecord
    has_many :expense_members
    belongs_to :group
    belongs_to :user
end

