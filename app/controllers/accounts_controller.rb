class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # before_action :can_modify_post, only: %i[ show edit update destroy ]
  

  # GET /accounts or /accounts.json
  def index
    # byebug
    @accounts = current_user.accounts
    # authorize @accounts
  end

  # GET /accounts/1 or /accounts/1.json
  def show
    authorize @account
  end

  # GET /accounts/new
  def new
    @account = Account.new
   

  end

  # GET /accounts/1/edit
  def edit
    authorize @account
  end

  # POST /accounts or /accounts.json
  def create
    # authorize @accounts
    @account = Account.new(account_params)
    @account.user_id=current_user.id
   

  
      if @account.save
       redirect_to @account, notice: "Account was successfully created." 
      else
        render :new
      end
    
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    
      if @account.update(account_params)
        redirect_to @account, notice: "Account was successfully updated." 
      else
       render :edit, status: :unprocessable_entity 
      end
    
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    authorize @account
      @account.destroy
       redirect_to accounts_url, notice: "Account was successfully destroyed." 
    end
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
      # authorize @accounts
    end
    # def can_modify_post
    #   redirect_to( accounts_url,) and return unless  @account.user_id==current_user.id
    # end


    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:accountnumber, :accountname, :accounttype, :accountbalance)
    end
end
