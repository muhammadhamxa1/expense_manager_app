class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :accounts
         has_one :wallet
         has_many :transactions
         has_many :expenses ,class_name: 'Expense'
         has_many :incomes ,class_name: 'Income'
         has_many :transfers ,class_name: 'Transfer'
         delegate :expense,:income,:transfer,to: :transations
         has_many :group_members
         has_many :groups, through: :group_members       


end

