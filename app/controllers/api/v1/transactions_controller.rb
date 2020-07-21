class Api::V1::TransactionsController < ApplicationController
    def index
        transactions = current_user.transactions
        if transactions
          options = {
            include: [:budget]
          }
          render json: transactions.to_json(:include => {
            :budget => {:only => [:id, :amount, :webiste]},
          }, :except => [:updated_at])
        else
          render json: {errors: "error getting user transactions"}, status: :not_acceptable
        end
        
    end
end
