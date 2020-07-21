class Api::V1::BudgetsController < ApplicationController
    def index
        budgets = current_user.budgets
        if budgets
          options = {
            include: [:transactions],
            include: :category
          }
          render json: budgets.to_json(:include => {
            :transactions => {:only => [:amount, :name, :date, :transaction_type]}, 
            :category => {:only => [:name, :percentage, :tags]}
          }, :except => [:updated_at])
        else
          render json: {errors: "error getting user budgets"}, status: :not_acceptable
        end
    end
end
