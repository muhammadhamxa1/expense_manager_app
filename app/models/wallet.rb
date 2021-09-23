class Wallet < ApplicationRecord
    belongs_to :user
    has_many :transactions, as: :transaction_to
    has_many :transactions, as: :transaction_from

    validates :walletbalance,presence: true
end
