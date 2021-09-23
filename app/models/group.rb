class Group < ApplicationRecord
    has_many :users
    has_many :group_members, through: :users 
end
