class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = current_user.transactions
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
   @transaction.user_id=current_user.accounts
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id=current_user.id

      if @transaction.save
       redirect_to @transaction, notice: "Transaction was successfully created." 
      else
      render :new, status: :unprocessable_entity 
      end
   
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update

      if @transaction.update(transaction_params)
         redirect_to @transaction, notice: "Transaction was successfully updated." 
      else
        render :edit, status: :unprocessable_entity
      end
    
  end
  

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    redirect_to transactions_url, notice: "Transaction was successfully destroyed." 
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:type, :transaction_amount, :transfer_for, :transfer_id, :category, :transfer_from)
    end
end
