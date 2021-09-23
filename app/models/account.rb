class Account < ApplicationRecord
    belongs_to :user
    has_many :transactions, as: :transaction_to
    has_many :transactions, as: :transaction_from
    
    validates :accountnumber,:accountname, uniqueness: true

    validates :accountnumber, :accountname, :accountbalance, presence: true
end
