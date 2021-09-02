class Transaction < ApplicationRecord
    self.inheritance_column = :type 
    enum category: [:Food,:Transportation,:Accommodation]
    belongs_to :user
    def self.type
        %w(Expense Income Transaction)
    end
    scope :expense, -> {where(type: 'Expense')}

    scope :income, -> {where(type: 'Income')}
    
    scope :transfer, -> {where(type: 'Transfer')}

end
