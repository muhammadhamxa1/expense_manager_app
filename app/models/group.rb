class Group < ApplicationRecord
    has_many :group_members

    has_many :users, through: :group_members

    belongs_to :user

    has_many :group_expenses
end
