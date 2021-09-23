class Group_Member < ApplicationRecord
    belongs_to :user
    belongs_to :group_member
end