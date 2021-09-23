class Transaction < ApplicationRecord
    
    self.inheritance_column = :type 
    
    enum category: [:Food,:Transportation,:Accommodation]
    belongs_to :user
    
    scope :expense, -> {where(type: 'Expense')}

    scope :income, -> {where(type: 'Income')}
    
    scope :transfer, -> {where(type: 'Transfer')}

    belongs_to :transaction_to, polymorphic: true,optional: true
    belongs_to :transaction_from, polymorphic: true,optional: true

    
     validates :transaction_amount,:transfer_from_id,:type,presence: true

 


    
    

end
