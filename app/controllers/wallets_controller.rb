class WalletsController < ApplicationController
  before_action :set_wallet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /wallets or /wallets.json
  def index
    @wallet = current_user.wallet
  end

  # GET /wallets/1 or /wallets/1.json
  def show
    authorize @wallet
  end

  # GET /wallets/new
  def new
    @wallet =Wallet.new
    authorize @wallet
  end

  # GET /wallets/1/edit
  def edit
    authorize @wallet
  end


  # POST /wallets or /wallets.json
  def create 
    authorize @wallet
    @wallet = Wallet.new(wallet_params)
    @wallet.user_id=current_user.id

    if @wallet.save
      redirect_to @wallet, notice: "Wallet was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /wallets/1 or /wallets/1.json
  def update

    if @wallet.update(wallet_params)
      redirect_to @wallet, notice: "Wallet was successfully updated." 
    else
      render :edit, status: :unprocessable_entity
    end
    
  end

  # DELETE /wallets/1 or /wallets/1.json
  def destroy
    authorize @wallet
    @wallet.destroy
  
   redirect_to wallets_url, notice: "Wallet was successfully destroyed." 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:walletbalance)
    end
end
