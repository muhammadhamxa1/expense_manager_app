class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  

  # GET /transactions or /transactions.json
  def index
    @transactions = current_user.transactions
    authorize @transactions
  end

  # GET /transactions/1 or /transactions/1.json
  def show
    authorize @transaction
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @accounts_name=current_user.accounts.pluck(:accountname,:id)
    @accounts_name.push([current_user.wallet.class.name,current_user.wallet.id])
  end

  # GET /transactions/1/edit
  def edit
    @accounts_name=current_user.accounts.pluck(:accountname,:id)
    @accounts_name.push([current_user.wallet.class.name,current_user.wallet.id])
    authorize @transaction
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = current_user.transactions.new(transaction_params)
    @transcation_ammount=@transaction.transaction_amount

    if @transaction.type == "Expense"
      if @transaction.transfer_from_type == "Wallet"
        @user_wallet_balance=current_user.wallet.walletbalance
        if @user_wallet_balance > 0 && @user_wallet_balance > @transcation_ammount
          current_user.wallet.walletbalance -= @transcation_ammount
          current_user.wallet.save
        else 
           redirect_back fallback_location: new_transaction_path, notice: "Wallet have Insufficent"
           return
        end
      elsif @transaction.transfer_from_type == "Account"
        @user_account = Account.find(@transaction.transfer_from_id)
        @user_account_balance=@user_account.accountbalance
        if @user_account_balance > 0 && @user_account_balance > @transcation_ammount
          @user_account.accountbalance -= @transcation_ammount
          @user_account.save
        else 
           redirect_back fallback_location: new_transaction_path, notice: "Account have Insufficent"  
           return        # byebug
        end  
      end

    elsif @transaction.type == "Income"
      @transaction.category=""
      if @transaction.transfer_from_type == "Wallet"
        current_user.wallet.walletbalance +=  @transcation_ammount 
        current_user.wallet.save
      elsif @transaction.transfer_from_type == "Account"
        @user_account = Account.find(@transaction.transfer_from_id)
        @user_account.accountbalance  += @transcation_ammount
        @user_account.save
      end

    elsif @transaction.type == "Transfer"
      @transaction.category=""
      if @transaction.transfer_from_type == "Wallet"
        @user_account = Account.find(@transaction.transfer_to_id)
        if current_user.wallet.walletbalance > 0 && current_user.wallet.walletbalance > @transcation_ammount
          @user_account.accountbalance  += @transcation_ammount
          current_user.wallet.walletbalance -= @transcation_ammount
          @user_account.save
          current_user.wallet.save
        else 
          redirect_back fallback_location: new_transaction_path, notice: "Wallet have Insufficent"
          return
        end

      elsif @transaction.transfer_from_type == "Account" &&  @transaction.transfer_to_type =="Account"
        @user_account_from = Account.find(@transaction.transfer_from_id)
        @user_account_to = Account.find(@transaction.transfer_to_id)
        if @user_account_from.accountbalance > 0 && @user_account_from.accountbalance > @transcation_ammount
          @user_account_from.accountbalance  -=  @transcation_ammount
          @user_account_to.accountbalance  += @transcation_ammount
          @user_account_to.save
          @user_account_from.save
        else 
          redirect_back fallback_location: new_transaction_path, notice: "Account have Insufficent"
          return
        end

      elsif @transaction.transfer_from_type == "Account"  
        @user_account = Account.find(@transaction.transfer_from_id)
        if @user_account.accountbalance > 0 && @user_account.accountbalance > @transcation_ammount
          current_user.wallet.walletbalance += @transcation_ammount
          @user_account.accountbalance  -= @transcation_ammount
          @user_account.save
          current_user.wallet.save
        else 
          redirect_back fallback_location: new_transaction_path, notice: "Account have Insufficent"
          return
        end
      end
    end

    if @transaction.save
      redirect_to transaction_path(@transaction), notice: "Transaction was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    # byebug
    @check_status_redirect=reverse_ammount
    @transcation_ammount=update_params[:transaction_amount].to_i

    if update_params[:type] == "Expense" && @check_status_redirect==0
      @transaction.transfer_to_id=""
      @transaction.transfer_to_type=""
      @transaction.save
      @updated_params=update_params.except(:transfer_to_id,:transfer_to_type)
      if update_params[:transfer_from_type] == "Wallet"
        @user_wallet_balance=current_user.wallet.walletbalance
        if @user_wallet_balance > 0 && @user_wallet_balance > @transcation_ammount 
          current_user.wallet.walletbalance -= @transcation_ammount
          current_user.wallet.save
          if @transaction.update(@updated_params)
            redirect_to @transaction, notice: "Transaction was successfully updated." 
            return
          end
        else
          redirect_back fallback_location: new_transaction_path, notice: "Wallet have Insufficent"
          return
        end

      elsif update_params[:transfer_from_type] == "Account" 
        @user_account = Account.find(@transaction.transfer_from_id)
        @user_account_balance=@user_account.accountbalance
        if @user_account_balance > 0 && @user_account_balance > @transcation_ammount
          @user_account.accountbalance -= @transcation_ammount
          @user_account.save
          if @transaction.update(@updated_params)
            redirect_to @transaction, notice: "Transaction was successfully updated." 
          end
        else 
            redirect_back fallback_location: new_transaction_path, notice: "Account have Insufficent" 
            return         # byebug
        end  
      end

    elsif update_params[:type] == "Income" && @check_status_redirect==0
      @transaction.category=""
      @transaction.transfer_to_id=""
      @transaction.transfer_to_type=""
      @transaction.save
      @updated_params=update_params.except(:category,:transfer_to_id,:transfer_to_type)
     if update_params[:transfer_from_type] == "Wallet"
       current_user.wallet.walletbalance +=  @transcation_ammount 
       current_user.wallet.save
       if @transaction.update(@updated_params)
        redirect_to @transaction, notice: "Transaction was successfully updated."
        return 
       end

     elsif update_params[:transfer_from_type] == "Account"
       @user_account = Account.find(@transaction.transfer_from_id)
       @user_account.accountbalance  += @transcation_ammount
       @user_account.save
       if @transaction.update(@updated_params)
        redirect_to @transaction, notice: "Transaction was successfully updated."
        return 
       end
     end

    elsif update_params[:type]== "Transfer" && @check_status_redirect==0
      @transaction.category=""
      @transaction.save
      @updated_params=update_params.except(:category)
      if update_params[:transfer_from_type] == "Wallet"
        @user_account = Account.find(@transaction.transfer_to_id)
        if current_user.wallet.walletbalance > 0 && current_user.wallet.walletbalance > @transcation_ammount
          @user_account.accountbalance  += @transcation_ammount
          current_user.wallet.walletbalance -= @transcation_ammount
          @user_account.save
          current_user.wallet.save
          if @transaction.update(@updated_params)
            redirect_to @transaction, notice: "Transaction was successfully updated." 
          end
        else 
          redirect_back fallback_location: new_transaction_path, notice: "Wallet have Insufficent"
          return
        end

      elsif update_params[:transfer_from_type] == "Account" && update_params[:transfer_to_type ] =="Account"
        @user_account_from = Account.find(@transaction.transfer_from_id)
        @user_account_to = Account.find(@transaction.transfer_to_id)
        
        if @user_account_from.accountbalance > 0 && @user_account_from.accountbalance > @transcation_ammount
          @user_account_from.accountbalance  -=  @transcation_ammount
          @user_account_to.accountbalance  += @transcation_ammount
          @user_account_to.save
          @user_account_from.save
          if @transaction.update(@updated_params)
            redirect_to @transaction, notice: "Transaction was successfully updated." 
          end
        else 
          redirect_back fallback_location: new_transaction_path, notice: "Account have Insufficent" 
          return
        end

      elsif update_params[:transfer_from_type] == "Account"  
        @user_account = Account.find(@transaction.transfer_from_id)
        if @user_account.accountbalance > 0 && @user_account.accountbalance > @transcation_ammount
          current_user.wallet.walletbalance += @transcation_ammount
          @user_account.accountbalance  -= @transcation_ammount
          @user_account.save
          current_user.wallet.save
          if @transaction.update(@updated_params)
            redirect_to @transaction, notice: "Transaction was successfully updated." 
          end
        else 
          redirect_back fallback_location: new_transaction_path, notice: "Account have Insufficent"
          return
        end
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @check_status_redirect=reverse_ammount
    
    if @check_status_redirect==0
      @transaction.destroy
      redirect_to transactions_url, notice: "Transaction was successfully destroyed." 
    end
    authorize @transaction
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      # byebug
      params.require(:transaction).permit(:type, :transaction_amount, :transfer_from_type, :transfer_from_id, :category, :transfer_to_id,:transfer_to_type,:transaction_date)
    end

    def update_params
      params.require(params[:type].to_sym).permit(:type, :transaction_amount, :transfer_from_type, :transfer_from_id, :category, :transfer_to_id,:transfer_to_type,:transaction_date)
    end

    def reverse_ammount
      @transcation_ammount=@transaction.transaction_amount
      @wallet = current_user.wallet
      # byebug
      @check=0
      if @transaction.type == "Expense"
        if @transaction.transfer_from_type == "Wallet"
          @wallet.walletbalance += @transcation_ammount 
          @wallet.save
          return @check
        elsif @transaction.transfer_from_type == "Account"
          @user_account = Account.find(@transaction.transfer_from_id)
          @user_account.accountbalance  += @transcation_ammount
          @user_account.save
          return @check
        end
      elsif @transaction.type == "Income"
        if @transaction.transfer_from_type == "Wallet"
          @check_income=@wallet.walletbalance -= @transcation_ammount 
          if @check_income < 0
            @check=1
            redirect_to transactions_url, notice: "Transaction Can't be revert"
            return @check
          else
            @wallet.save
          end
        elsif @transaction.transfer_from_type == "Account"
          @user_account = Account.find(@transaction.transfer_from_id)
          @check_income=@user_account.accountbalance  -= @transcation_ammount
          if @check_income < 0
            @check=1
            redirect_to transactions_url, notice: "TRansaction Can't be revert"
            return @check
          else
          @user_account.save
          return @check
          end
        end
      elsif @transaction.type == "Transfer"
          if @transaction.transfer_from_type == "Wallet"
            @user_account = Account.find(@transaction.transfer_to_id)
            @user_account.accountbalance  -= @transcation_ammount
            @wallet.walletbalance +=  @transcation_ammount
            @user_account.save
            @wallet.save
            return @check
          elsif @transaction.transfer_from_type == "Account" &&  @transaction.transfer_to_type =="Account"
            @user_account_from = Account.find(@transaction.transfer_from_id)
            @user_account_to = Account.find(@transaction.transfer_to_id)
            @user_account_from.accountbalance  += @transcation_ammount
            @user_account_to.accountbalance  -= @transcation_ammount
            @user_account_to.save
            @user_account_from.save
            return @check
          elsif @transaction.transfer_from_type == "Account"
            @user_account = Account.find(@transaction.transfer_from_id)
            @wallet.walletbalance -= @transcation_ammount
            @user_account.accountbalance  += @transcation_ammount
            @user_account.save
            @wallet.save
            return @check
          end
      end
    end
end