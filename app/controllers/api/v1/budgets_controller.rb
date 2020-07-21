class Api::V1::BudgetsController < ApplicationController
    def index
        budgets = current_user.budgets
        if budgets
          options = {
            include: [:transactions]
          }
          render json: budgets.to_json(:include => {
            :transactions => {:only => [:amount, :name, :date, :transaction_type]},
          }, :except => [:updated_at])
        else
          render json: {errors: "error getting user budgets"}, status: :not_acceptable
        end
    end
end
