class GroupExpensesController < ApplicationController
  before_action :set_group_expense, only: %i[ show edit update destroy ]

  # GET /group_expenses or /group_expenses.json
  def index
    @group_expenses = GroupExpense.all
  end

  # GET /group_expenses/1 or /group_expenses/1.json
  def show
  end

  # GET /group_expenses/new
  def new
    # byebug
    @group = Group.find(params[:group_id])
    @group_expense = @group.group_expenses.new

  end

  # GET /group_expenses/1/edit
  def edit
  end

  # POST /group_expenses or /group_expenses.json
  def create
    @group = Group.find(params[:group_id])
    @group_expense = @group.group_expenses.new
    byebug

  
      if @group_expense.save
        redirect_to @group_group_expenses_path, notice: "Group expense was successfully created." 
      else
        render :new, status: :unprocessable_entity 
      end
  
  end

  # PATCH/PUT /group_expenses/1 or /group_expenses/1.json
  def update
      if @group_expense.update(group_expense_params)
         redirect_to @group_expense, notice: "Group expense was successfully updated." 
      else
          render :edit, status: :unprocessable_entity 
      end
   
  end

  # DELETE /group_expenses/1 or /group_expenses/1.json
  def destroy
    @group_expense.destroy
   
    redirect_to group_expenses_url, notice: "Group expense was successfully destroyed." 

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_expense
      @group.group_id =Group.find((params[:group_id]))
 
      @group_expense = GroupExpense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_expense_params
      
      params.require(:group_expense).permit(:expense_name,:expense_amount)
    end
end
