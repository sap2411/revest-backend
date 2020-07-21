require_relative '../../../models/transaction.rb'
class Api::V1::PlaidController < ApplicationController
    include Plaid
  
    def plaidlogin 
      token = params[:token]
      @access_token = Plaid.generate_access_token(token)
  
      if @access_token
        render json: {
          access_token: @access_token
        }
      else
        render json: {
          status: 500,
          errors: ['Missing Access Token']
        }
      end
    end
  
    def getTransactions
      @transactions = Transaction.fetch_and_build(params[:access_token], current_user)
      byebug
      if @transactions
        render json: { user: UserSerializer.new(current_user), transactions: TransactionSerializer.new(current_user.transactions)}, status: :created
      else 
        render json: {
          status: 500,
          errors: ['No Transaction Data Found']
        }
      end
    end
  
  end 