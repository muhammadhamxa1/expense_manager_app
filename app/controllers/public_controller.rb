class PublicController < ApplicationController
    def index
        @sum = sumOpinion(@opinion)
        
    end
    def homepage
      if (user_signed_in?)
        @opinion =current_user.transactions.pluck(:type,:transaction_amount)
        @aggregate = aggregateOpinion(@opinion)
        @aggregate << ["Wallet",current_user.wallet.walletbalance]
        @aggregate<<["Current Balnce",current_user.accounts.sum(:accountbalance)-@aggregate[0][1].to_f]
      end
      @transaction=Transaction.new
      @accounts_name=current_user.accounts.pluck(:accountname,:id)
      @accounts_name.push([current_user.wallet.class.name,current_user.wallet.id])
    end
    def aggregateOpinion(array)
        result = [["Expense",0],["Income",0]]
        array.each do |i|
          if i[0] == "Expense"
            result[0][1] += i[1]
          elsif  i[0] == "Income"
            result[1][1] += i[1]
          end
        end
        return result
    end
end
