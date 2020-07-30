class Api::V1::TransactionsController < ApplicationController
    def index
      # show all the transactions for a user
        transactions = current_user.transactions
        if transactions
          options = {
            include: [:budget]
          }
          render json: transactions.to_json(:include => {
            :budget => {:only => [:id, :amount]},
          }, :except => [:updated_at])
        else
          render json: {errors: "error getting user transactions"}, status: :not_acceptable
        end
        
    end

    def update
      # update the budget association for a transaction
      transaction = Transaction.find(params[:id])
      transaction.update(transaction_params)
      if transaction.valid?
          render json: TransactionSerializer.new(transaction)
      else
          render json: {errors: transaction.errors.full_messages}
      end
    end
  
    private
   
    def transaction_params
      params.require(:transaction).permit(:budget_id)
    end
end
