class ExpenseMember < ApplicationRecord
  belongs_to :group_expense 
  belongs_to :lenter,:class_name => 'User',:foreign_key => :lenter_id
  belongs_to :borror,:class_name => 'User',:foreign_key => :borror_id
end
