class Api::V1::BudgetsController < ApplicationController
  def index
      budgets = current_user.budgets
      if budgets
        options = {
          include: [:transactions],
          include: :category
        }
        render json: budgets.to_json(:include => {
          :transactions => {:only => [:amount, :name, :date, :transaction_type, :id]}, 
          :category => {:only => [:name, :percentage, :tags]}
        }, :except => [:updated_at])
      else
        render json: {errors: "error getting user budgets"}, status: :not_acceptable
      end
  end

  def update
    budget = Budget.find(params[:id])
    budget.update(budget_params)
    if budget.valid?
        render json: BudgetSerializer.new(budget)
    else
        render json: {errors: budget.errors.full_messages}
    end
  end

  private
 
  def budget_params
    params.require(:budget).permit(:amount)
  end
end
